# Browser-Use Web Automation & CDP Integration

This reference documents the setup, installation, troubleshooting, and execution patterns for `browser-use` (browser automation AI agent framework) in Linux container environments.

---

## 1. Installation & Environment Setup

1. **Clone & Editable Package Installation:**
   ```bash
   git clone https://github.com/browser-use/browser-use.git /data/browser-use
   python3 -m pip install -e /data/browser-use
   ```

2. **Playwright Chromium Binary & Dependency Setup:**
   ```bash
   # Install Chromium browser binaries
   python3 -m pip install playwright
   python3 -m playwright install chromium

   # System shared libraries required on Debian/Ubuntu Linux:
   # libnspr4, libnss3, libatk1.0-0, libatk-bridge2.0-0, libcups2, libdrm2,
   # libxcomposite1, libxdamage1, libxfixes3, libxrandr2, libgbm1, libpango-1.0-0, libcairo2
   ```

3. **Required PyTest Testing Extensions:**
   ```bash
   python3 -m pip install pytest-xdist pytest-httpserver
   ```

---

## 2. Linux Container Headless Sandbox Configuration

In unprivileged root/container environments, Chrome/Chromium requires explicit sandbox flags and extension settings to initialize CDP (Chrome DevTools Protocol) debugging ports without timing out:

```python
from browser_use import Browser

# Configure Browser session for Linux container environments
browser = Browser(
    headless=True,
    enable_default_extensions=False, # Prevents extension download timeouts
    args=[
        "--no-sandbox",
        "--disable-setuid-sandbox",
        "--disable-dev-shm-usage",
        "--disable-gpu"
    ]
)
```

---

## 3. Supported LLM Adapters in Browser-Use

`browser-use` exports dedicated chat model adapters:

```python
from browser_use import Agent, Browser

# Option 1: ChatBrowserUse (Fastest, optimized for browser tasks)
from browser_use import ChatBrowserUse
llm = ChatBrowserUse(model="bu-2-0") # Requires BROWSER_USE_API_KEY

# Option 2: ChatGoogle (Gemini)
from browser_use import ChatGoogle
llm = ChatGoogle(model="gemini-2.5-flash", api_key="...")

# Option 3: ChatOpenAI
from browser_use import ChatOpenAI
llm = ChatOpenAI(model="gpt-4o")

# Option 4: ChatAnthropic
from browser_use import ChatAnthropic
llm = ChatAnthropic(model="claude-3-7-sonnet")
```

---

## 4. Custom Action Controllers & Structured Extraction

Define custom actions using `Controller`:

```python
from browser_use import Agent, Browser, Controller, ChatGoogle

controller = Controller()

@controller.action("Extract Page Title and Headlines")
def extract_headlines(page_content: str):
    return {"extracted": True, "preview": page_content[:200]}

async def run_task():
    llm = ChatGoogle(model="gemini-2.5-flash")
    browser = Browser(headless=True, enable_default_extensions=False)
    
    agent = Agent(
        task="Extract top story headlines from HN",
        llm=llm,
        browser=browser,
        controller=controller
    )
    
    result = await agent.run()
    return result
```

---

## 5. Remote CDP & Cloud Browsers

For stealth bypass, anti-bot handling, or scaled execution:

```python
# Connect to Remote CDP Endpoint
browser = Browser(cdp_url="http://remote-host:9222")

# Connect to Browser-Use Cloud
browser = Browser(use_cloud=True) # Requires BROWSER_USE_API_KEY
```
