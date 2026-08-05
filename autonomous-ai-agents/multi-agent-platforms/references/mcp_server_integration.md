# MCP (Model Context Protocol) Server Integration & Native Tool Discovery

This reference documents the process for installing, compiling, registering, and verifying Model Context Protocol (MCP) servers (e.g. `firecrawl-mcp-server`) natively within Hermes Agent.

---

## 1. Installation & Build Process (Stdio Transport)

1. **Clone & Compile MCP Server:**
   ```bash
   git clone https://github.com/<org>/<mcp-server>.git /data/<mcp-server>
   cd /data/<mcp-server>
   npm install && npm run build
   ```
   *Output entrypoint:* Compiled Node.js distribution binary at `/data/<mcp-server>/dist/index.js` (or `build/index.js`).

2. **Install MCP Python SDK Dependency:**
   ```bash
   python3 -m pip install mcp
   ```

---

## 2. Registering MCP Server with Hermes CLI

Use the native `hermes mcp add` command with non-interactive confirmation:

```bash
# Add Stdio MCP Server (using local compiled Node.js binary)
echo "Y" | /opt/venv/bin/hermes mcp add <server-name> \
  --command "node" \
  --args "/data/<mcp-server>/dist/index.js"

# Alternatively: Add Remote HTTP Transport MCP Server
echo "Y" | /opt/venv/bin/hermes mcp add <server-name> \
  --url "https://mcp.example.com/v2/mcp"
```

---

## 3. Testing & Verification Protocols

1. **Inspect Registered MCP Servers & Connection Status:**
   ```bash
   /opt/venv/bin/hermes mcp list
   /opt/venv/bin/hermes mcp test <server-name>
   ```

2. **Programmatic RPC Tool Invocation Test (`asyncio` + `mcp.ClientSession`):**
   ```python
   import asyncio
   from mcp import ClientSession, StdioServerParameters
   from mcp.client.stdio import stdio_client

   async def verify_mcp():
       params = StdioServerParameters(command="node", args=["/data/<mcp-server>/dist/index.js"])
       async with stdio_client(params) as (read, write):
           async with ClientSession(read, write) as session:
               await session.initialize()
               tools = await session.list_tools()
               print(f"Connected! Total tools discovered: {len(tools.tools)}")
               res = await session.call_tool("firecrawl_search", {"query": "Test Query"})
               print("Tool Output:", res)

   asyncio.run(verify_mcp())
   ```

3. **Keyless Free Tier vs API Key Modes (Firecrawl Pattern):**
   * **Keyless Free Tier:** Read-only search & single-page scraping tools (`firecrawl_search`, `firecrawl_scrape`) run without an API key (IP rate-limited).
   * **API Key Tier:** Pass `FIRECRAWL_API_KEY` in server environment or configuration to unlock full crawling, mapping, structure extraction, and agentic search tools.
