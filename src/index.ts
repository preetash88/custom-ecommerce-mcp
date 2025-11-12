// Export main library components

export { ProductService } from "./services/ProductService.js";
export type { Product } from "./models/Product.js";

// Re-export MCP SDK types for convenience

export type { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
export type { SSEServerTransport } from "@modelcontextprotocol/sdk/server/sse.js";

// Keep the original demo functionality
import { ProductService } from './services/ProductService.js';

async function runDemo() {
  const svc = new ProductService();

  // Demo flow (no HTTP): add → list → read → update → delete
  const created = await svc.addProduct({
    sku: 'DEMO-001',
    name: 'Demo Product',
    description: 'Just a demo product for tutorial',
    price: 9.99,
    quantity: 5,
  });
  console.log('Created:', created);

  const one = await svc.getProductById(created.id!);
  console.log('Read back:', one);

  const updated = await svc.updateProduct({ id: created.id!, price: 12.49, quantity: 7 });
  console.log('Updated:', updated);

  const results = await svc.listProducts(10, 0);
  console.log('List:', results);

  const ok = await svc.deleteProduct(created.id!);
  console.log('Deleted?', ok);
}

// Run demo if this file is executed directly
if (import.meta.url === `file://${process.argv[1]}`) {
  runDemo().catch((err: any) => {
    console.error(err);
    process.exit(1);
  });
}
