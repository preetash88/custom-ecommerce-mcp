#!/usr/bin/env node

import { McpServer } from "@modelcontextprotocol/sdk/server/mcp";
import z from "zod";
import { ProductService } from "../services/ProductService";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio";
import { features } from "process";

const inputProductSchema = z.object({
  sku: z.string().min(1),
  name: z.string().min(1),
  description: z.string().optional().nullable(),
  price: z.number().nonnegative(),
  quantity: z.number().int().nonnegative(),
});

const outputProductSchema = z.object({
  id: z.number().int().positive().optional(),
  sku: z.string().min(1),
  name: z.string().min(1),
  description: z.string().optional().nullable(),
  price: z.union([z.string(), z.number()]),
  quantity: z.coerce.number().int().nonnegative(),
  created_at: z.union([z.string(), z.date()]).optional(),
  updated_at: z.union([z.string(), z.date()]).optional(),
});

const updateProductSchema = z.object({
  id: z.number().int().positive(),
  sku: z.string().min(1).optional(),
  name: z.string().min(1).optional(),
  description: z.string().optional().nullable(),
  price: z.number().nonnegative().optional(),
  quantity: z.number().int().nonnegative().optional(),
});

//This line creates and registers a new MCP server instance — essentially, it’s the entry point or identity of your Model Context Protocol server.It’s how your program says:“Hey, I’m spinning up an MCP server called ecommerce-custom-mcp, version 1.0.0, that will expose certain tools, resources, and capabilities to AI agents (like ChatGPT, AutoGen, or OpenAI MCP clients).”
const mcp_server = new McpServer({
  name: "ecommerce-custom-mcp",
  version: "1.0.0",
});

// Instantiate the ProductService to handle product-related operations
const ps = new ProductService();

// Add an addition tool to add new products to the inventory
mcp_server.registerTool(
  "add_product",
  {
    title: "Add Product",
    description:
      "Create a new product with sku, name, description(optional but better to have), price, and quantity.",
    inputSchema: inputProductSchema.shape,
    outputSchema: outputProductSchema.shape,
  },
  async ({ sku, name, description, price, quantity }) => {
    const output = await ps.addProduct({
      sku,
      name,
      description,
      price,
      quantity,
    });
    return {
      content: [{ type: "text", text: JSON.stringify(output) }],
      structuredContent: output as any,
    };
  }
);

// Add an addition tool to fetch a single product by id
mcp_server.registerTool(
  "get_product_by_id",
  {
    title: "Get a Product by ID",
    description: "Fetch a product's details using its unique ID(number).",
    inputSchema: {
      id: z.number().int().positive(),
    },
    outputSchema: outputProductSchema.shape || z.null(),
  },
  async ({ id }) => {
    const output = await ps.getProductById(id);
    if (!output) {
      return {
        content: [{ type: "text", text: `Product with ID ${id} not found.` }],
        isError: true,
      };
    }
    return {
      content: [{ type: "text", text: JSON.stringify(output) }],
      structuredContent: output as any,
    };
  }
);

// Add an addition tool to delete a single product by id
mcp_server.registerTool(
  "delete_product",
  {
    title: "Delete a Product by ID",
    description:
      "Delete a product using its unique ID(number). Returns true if deletion was successful, false otherwise.",
    inputSchema: {
      id: z.number().int().positive(),
    },
    outputSchema: { success: z.boolean() },
  },
  async ({ id }) => {
    const output = await ps.deleteProduct(id);
    if (!output) {
      return {
        content: [
          {
            type: "text",
            text: `Product with ID ${id} not found. Please provide a valid ID for deletion`,
          },
        ],
        isError: true,
      };
    }
    return {
      content: [{ type: "text", text: JSON.stringify(output) }],
      structuredContent: output as any,
    };
  }
);

// Add an addition tool to update product
mcp_server.registerTool(
  "update_product",
  {
    title: "Update Product",
    description:
      "Update an existing product by providing correct id(mandatory) as input along with with sku(optional), name(optional), description(optional but better to have), price(optional), and quantity(optional).",
    inputSchema: updateProductSchema.shape,
    outputSchema: outputProductSchema.shape || z.null(),
  },
  async ({ id, sku, name, description, price, quantity }) => {
    const output = await ps.updateProduct({
      id,
      sku,
      name,
      description,
      price,
      quantity,
    });
    if (!output) {
      return {
        content: [
          {
            type: "text",
            text: `Product with ID ${id} not found. Please provide a valid ID to update the Product details`,
          },
        ],
        isError: true,
      };
    }
    return {
      content: [{ type: "text", text: JSON.stringify(output) }],
      structuredContent: output as any,
    };
  }
);

// Register a resource that provides a list of all products in the catalog
mcp_server.registerResource(
  "product_catalog",
  "products://catalog",
  {
    title: "Product Catalog",
    description:
      "A catalog of products available in the e-commerce store, including their details such as SKU, name, description, price, and quantity in stock.",
  },
  async (uri) => {
    const products = await ps.listProducts(100, 0);
    return {
      contents: [
        { uri: uri.href, type: "text", text: JSON.stringify(products) },
      ],
    };
  }
);

// Register a resource that provides a list of products with low inventory
mcp_server.registerResource(
  "low_product_inventory",
  "products://low_inventory",
  {
    title: "Low Product Inventory",
    description:
      "A list of products that have low inventory levels and may need restocking soon.",
  },
  async (uri) => {
    const products = await ps.listProducts(100, 0);
    const lowInventoryProducts = products.filter((p) => p.quantity < 10);
    return {
      contents: [
        {
          uri: uri.href,
          type: "text",
          text: JSON.stringify(lowInventoryProducts),
        },
      ],
    };
  }
);

// Add an addition tool to add new products to the inventory smartly- Sampling AI generated description if missing
mcp_server.registerTool(
  "add_product_smartly",
  {
    title: "Add Product Smartly",
    description:
      "Create a new product with sku, name, description(optional), price, and quantity. Since description is optional, is description is missing, use smart AI generated description if missing. This tool also checks for existing products with the same SKU to prevent duplicates.",
    inputSchema: inputProductSchema.shape,
    outputSchema: outputProductSchema.shape,
  },
  async (raw) => {
    const args = inputProductSchema.parse(raw);
    let finalDescription = args.description;
    if (!finalDescription) {
      // Generate a smart description using AI
      const prompt = `Generate a concise and appealing product description for ${args.name}`;
      const response = await mcp_server.server.createMessage({
        messages: [
          {
            role: "user",
            content: {
              type: "text",
              text: prompt,
            },
          },
        ],
        maxTokens: 100,
      });
      finalDescription =
        (response.content.text as string) || "No description available.";
    }
    const output = await ps.addProduct({
      ...args,
      description: finalDescription,
    });
    return {
      content: [{ type: "text", text: JSON.stringify(output) }],
      structuredContent: output as any,
    };
  }
);

mcp_server.registerPrompt(
  "generate_product_description_template",
  {
    title: "Generate Product Description Template",
    description:
      "Generates a concise and appealing product description template based on the product name provided.",
    argsSchema: {
      product_name: z.string().describe("Name of the product"),
      features: z.string().optional().describe("Key features of the product"),
      target_audience: z
        .string()
        .optional()
        .describe("Intended audience for the product: Demographics"),
    },
  },
  ({ product_name, features, target_audience }) => ({
    messages: [
      {
        role: "user",
        content: {
          type: "text",
          text: `Create an appealing  product description template for a product named "${product_name}". 
          ${features ? `Key features: ${features}.` : ""}
          ${target_audience ? `Target audience: ${target_audience}.` : ""}
          
          Please create:
          1. A catchy opening line(5-8 words).
          2. A brief description(2-3 paragraphs).
          3. A list of 3 key features.
          4. A closing statement(5-8 words) encouraging purchase.
          
          make it engainging, SEO friendly and persuasive.`,
        },
      },
    ],
  })
);

// Connect the server using standard input/output transport
(async () => {
  const transport = new StdioServerTransport();
  await mcp_server.connect(transport);
})();
