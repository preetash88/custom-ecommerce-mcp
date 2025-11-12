# MCP E-commerce Server

A comprehensive Model Context Protocol (MCP) server for e-commerce product management with CRUD operations, AI-powered descriptions, and database integration.

## Features

- 🛍️ **Complete CRUD Operations** - Create, read, update, delete products
- 🤖 **AI-Powered Descriptions** - Automatic product description generation using MCP sampling
- 📊 **Database Integration** - MySQL database with proper schema
- 🔍 **Smart Search** - Search products by name with pagination
- 📦 **Low Stock Monitoring** - Resource for tracking inventory levels
- 🌐 **Dual Transport Support** - Both stdio and HTTP/SSE transports
- 🔧 **TypeScript** - Fully typed with Zod validation
- 📋 **MCP Resources** - Product catalog and low-stock resources
- 🎯 **MCP Prompts** - Pre-built prompt templates


## Quick start
```bash
# 1) Install deps
npm i

# 2) Prepare env
cp .env.example .env

# 3) Create schema (optional, run in your MySQL)
# See sql/schema.sql

# 4) Run demo (non-MCP) usage
npm run dev:demo

# 5) Run MCP server (stdio transport)
npm run dev:mcp
```
The MCP server prints nothing special; it waits on stdio for a client like Claude Desktop / MCP Inspector / Apps SDK to connect.

## Notes
- This is intentionally minimal and tutorial‑friendly.
- All database params come from environment variables.
- You can extend with transactions, pagination, auth, etc.



#package.json
npm link

npm login
npm publish --access public
