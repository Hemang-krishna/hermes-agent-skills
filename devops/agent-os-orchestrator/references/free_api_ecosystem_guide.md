# Verified Free API Ecosystem Guide for Agent OS

This reference details the free tier providers and setup routes built into Agent OS (`server/runtime/provider-setup.js`).

## Provider Matrix

| Provider | Type | Default Model | Config Field | Allowance / Free Tier |
| :--- | :--- | :--- | :--- | :--- |
| **Ollama** | Local | `llama3.1` | `OLLAMA_HOST` | 100% Free Unlimited Local Hardware |
| **Gemini** | Cloud | `gemini-1.5-flash` | `GEMINI_API_KEY` | 15 RPM / 1M TPM Free Tier |
| **OpenRouter** | Cloud | `openrouter/auto` | `OPENROUTER_API_KEY` | 20+ Free Open Models (`:free`) |
| **MiniMax** | Cloud | `MiniMax-M3` | `MINIMAX_API_KEY` | Free Trial Tier |
| **Firecrawl** | Builder | `v2 Scrape/Search` | `FIRECRAWL_API_KEY` | 500 Free Scrapes |

## Configuration API Endpoints
When `node server/index.js` is running on port 4173:
- `POST /api/setup/providers/gemini/configure`
- `POST /api/setup/providers/openrouter/configure`
- `POST /api/setup/providers/ollama/configure`
