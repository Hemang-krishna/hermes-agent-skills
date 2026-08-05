# Google NotebookLM Extraction & Document Vault Reference

## Architecture & Integration Strategy (`notebooklm-py`)

Programmatic interaction with Google NotebookLM endpoints via `notebooklm-py` library (`/data/notebooklm-py`) and CLI (`/data/.local/bin/notebooklm`).

### 1. Authentication & Cookie Storage
- **Storage Path:** `~/.notebooklm/profiles/default/storage_state.json`
- **Importing Cookies:**
  ```bash
  /data/.local/bin/notebooklm auth import-cookies /path/to/cookies.json
  ```
- **Required Google Cookie Domains:** `SID`, `HSID`, `SSID`, `APISID`, `SAPISID`, `__Secure-1PSID`, `__Secure-3PSID`, `__Secure-1PSIDTS`.

### 2. Multi-Format Research Document Extraction
- **Listing Notebooks:** `notebooklm list`
- **Extracting Fulltext Markdown:** `notebooklm source fulltext <source_id> --notebook <notebook_id>`
- **Exporting Metadata & Sources:** `notebooklm metadata <notebook_id>`
- **Batch Downloading Artifacts:**
  ```bash
  notebooklm download audio --notebook <id> --output-dir <dir>
  notebooklm download report --notebook <id> --output-dir <dir>
  notebooklm download mind-map --notebook <id> --output-dir <dir>
  ```
- **Available Formats:** Audio MP3, Report PDF, Data-Table JSON, Flashcards, Mind-Map, Quiz, Slide Deck, Video MP4.

### 3. Endpoint Volatility & Triple-Fallback Strategy
1. **Tier 1 (Direct Async RPC):** Direct Python client using `notebooklm` module.
2. **Tier 2 (CLI Execution):** `/data/.local/bin/notebooklm` CLI commands.
3. **Tier 3 (Browser-Use Playwright CDP):** Headless Chromium DOM automation for UI click fallbacks when Google updates RPC signatures.
