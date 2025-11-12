#!/usr/bin/env node
// src/bin/cli.ts
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import { setupMcpServer } from "../mcp/setup.js";
async function main() {
    console.error("🚀 Starting MCP E-commerce Server (stdio)...");
    try {
        const server = setupMcpServer();
        const transport = new StdioServerTransport();
        await server.connect(transport);
        console.error("✅ MCP Server connected via stdio");
    }
    catch (error) {
        console.error("❌ Failed to start MCP server:", error);
        process.exit(1);
    }
}
main().catch(console.error);
