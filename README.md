# docker-mcp-postgres-read
This project creates a local PostgreSQL database with sample employee data, runs a read-only MCP server via Docker, and connects it to a Python AI agent that can answer natural language questions

# Docker MCP PostgreSQL Read-Only Server

Secure read-only PostgreSQL queries via Docker and the Model Context Protocol (MCP).

## Features
- ✅ **Read-only safety**: Prevents accidental writes/deletes
- 🐳 **Dockerized**: Runs in isolated containers
- 🤖 **AI-ready**: Compatible with LangChain/SQLDatabaseChain

## Quick Start
```bash
git clone https://github.com/abdulwahed-sweden/docker-mcp-postgres-read.git
cd docker-mcp-postgres-read
docker-compose up -d
