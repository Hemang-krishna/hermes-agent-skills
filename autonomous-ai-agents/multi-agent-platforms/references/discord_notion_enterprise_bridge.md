# Discord & Notion Enterprise Communication Bridge & Bulletproof Live Web Search

This reference covers the architecture, setup, troubleshooting, and bulletproof live web search integration for Discord bots connected with Notion workspaces in multi-agent platforms.

---

## 1. Discord Bot vs. Webhook Architecture

| Component | Discord Bot API (`Bot TOKEN`) | Discord Webhook URL |
| :--- | :--- | :--- |
| **Connection Method** | WebSocket Gateway (`wss://gateway.discord.gg`) | HTTP POST Endpoint |
| **Capabilities** | 24/7 background listener, interactive mentions, live commands, web search | One-way rich embed announcements |
| **Setup Needed** | Discord Developer Portal App + OAuth2 Bot Invite Link | Server Channel Settings -> Integrations -> Webhooks |

---

## 2. Gateway WebSocket Connection & Privileged Intents Troubleshooting

When initializing a `discord.py` bot:

```python
import discord
from discord.ext import commands

# Use default non-privileged intents to avoid PrivilegedIntentsRequired exceptions
intents = discord.Intents.default()
# intents.message_content = True  # Enable in Developer Portal -> Bot -> Message Content Intent

bot = commands.Bot(command_prefix="!", intents=intents)
```

### Critical Pitfall: `discord.errors.PrivilegedIntentsRequired`
* **Cause:** The code sets `intents.message_content = True` or `intents.members = True`, but the corresponding toggles are turned OFF under the **Bot** tab in the Discord Developer Portal.
* **Fix:** Either toggle **MESSAGE CONTENT INTENT** to `ON` in the Discord Developer Portal, or fallback to standard non-privileged `discord.Intents.default()`.

---

## 3. Implementing Bulletproof Live Web Search in Discord (`@Snorlax search` / Universal Catch-All)

### ⚠️ Critical Lessons & Pitfalls
1. **Never use Brittle Regex HTML Matching:** Standard DuckDuckGo HTML pages change CSS class names and wrapper tags frequently, causing `re.findall()` to return 0 matches and break silently.
2. **Use BeautifulSoup4 + DuckDuckGo Lite:** `https://lite.duckduckgo.com/lite/` provides a stable, structured table layout (`tr`, `a.result-link`, `td.result-snippet`) that extracts clean real-time titles, full snippets, and unquoted target links.
3. **Universal Catch-All Message Router:** Never restrict message handling to a narrow keyword list (`search`, `what is`, `how to`). When a team member @mentions the bot with any query (e.g. `@Snorlax give me the least boring ways to sit at work`), pass the prompt to a catch-all router that executes live web search + AI answer synthesis and ALWAYS responds with a rich embed card.
4. **No Empty Placeholder Responses:** Never output generic boilerplate strings ("Snorlax analyzed query..."). Render extracted search results with direct clickable Markdown links `[Open Link / Read Source](link)`.

### Production Code Reference (`perform_bulletproof_web_search`):

```python
import urllib.parse, urllib.request, re, discord
from bs4 import BeautifulSoup

def perform_bulletproof_web_search(query: str, limit: int = 4) -> list:
    """
    Bulletproof live web search using BeautifulSoup + DuckDuckGo Lite engine.
    Extracts real-time titles, clean snippets, and direct clickable target URLs.
    """
    encoded = urllib.parse.quote(query)
    url = "https://lite.duckduckgo.com/lite/"
    req = urllib.request.Request(
        url,
        data=f"q={encoded}".encode("utf-8"),
        headers={
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
            "Content-Type": "application/x-www-form-urlencoded"
        }
    )
    results = []
    try:
        with urllib.request.urlopen(req, timeout=10) as resp:
            html = resp.read().decode("utf-8", errors="ignore")
            soup = BeautifulSoup(html, "html.parser")
            rows = soup.find_all("tr")
            for i in range(0, len(rows) - 1):
                title_a = rows[i].find("a", class_="result-link")
                snippet_td = rows[i+1].find("td", class_="result-snippet")
                if title_a and snippet_td:
                    link = title_a.get("href", "")
                    if "//duckduckgo.com/l/?uddg=" in link:
                        link = urllib.parse.unquote(link.split("uddg=")[1].split("&")[0])
                    elif link.startswith("//"):
                        link = "https:" + link
                    
                    clean_title = title_a.get_text().strip()
                    clean_snippet = snippet_td.get_text().strip()
                    
                    if clean_title and clean_snippet:
                        results.append({
                            "title": clean_title,
                            "link": link,
                            "snippet": clean_snippet
                        })
    except Exception as e:
        pass

    return results[:limit]

# Universal Catch-All Router in on_message:
@bot.event
async def on_message(message):
    if message.author == bot.user:
        return

    if bot.user.mentioned_in(message) or message.content.startswith("!snorlax"):
        content = message.content.replace(f"<@{bot.user.id}>", "").strip()
        
        async with message.channel.typing():
            web_results = perform_bulletproof_web_search(content)

        if web_results:
            embed = discord.Embed(
                title=f"🔍 Live Web Research: {content[:100]}",
                description=f"Here are top real-time search results for {message.author.mention}:",
                color=0x10b981
            )
            for res in web_results:
                embed.add_field(
                    name=f"🌐 {res['title'][:200]}",
                    value=f"{res['snippet'][:300]}\n🔗 **[Open Link / Read Source]({res['link']})**",
                    inline=False
                )
            await message.channel.send(embed=embed)
```

---

## 4. Notion Workspace Sync, Team Directory & Twice-Daily Automated Check-In Routine

* **Team Directory Schema:** Store team members in Notion database (`Anya's Space`) with `name`, `role`, `email`, `discord_id`, and `status`.
* **Cross-Platform Broadcasts:** Dispatch rich colored embeds (`0x2563eb` for Blue, `0xf59e0b` for Gold Founder announcements) whenever team members join or tasks update in Notion.
* **Twice-Daily Automated Check-In Routine (`discord.ext.tasks`):**
  - **Morning Check-In (09:00 AM UTC):** Greets Founder, Tech Director, and workspace owner warmly. Rotates fresh, non-repetitive quotes from computer science pioneers and productivity architects. Asks for daily roadmap goals and reinforces 24/7 background AI support.
  - **Afternoon Check-In (02:00 PM / 14:00 UTC):** Asks about afternoon progress, offers anti-brain-fog micro-break protocols (3-minute screen breaks, rubber-duck debugging, 25-minute Pomodoro focus blocks), and checks for technical blockers.

```python
from discord.ext import tasks
import random, datetime

MOTIVATIONAL_QUOTES = [
    ("“Simplicity is prerequisite for reliability.” — Edsger W. Dijkstra", "Break complex automation nodes into small, focused sub-systems."),
    ("“The best way to predict the future is to invent it.” — Alan Kay", "Every AI flow you build today shapes autonomous infrastructure.")
]

@tasks.loop(minutes=15)
async def twice_daily_routine_check():
    now = datetime.datetime.utcnow()
    current_date = now.strftime("%Y-%m-%d")
    
    # Morning Check-In (09:00 UTC)
    if now.hour in [8, 9] and last_morning_checkin != current_date:
        quote, tip = random.choice(MOTIVATIONAL_QUOTES)
        embed = discord.Embed(title="🌅 Morning Energy Boost & Goal Check-In", description=f"📜 **Quote:** {quote}\n\n📌 What are our roadmap targets today?", color=0xf59e0b)
        await channel.send(embed=embed)
```

## 5. Mandatory GitHub Repository Push Workflow

Whenever new modules or codebases are generated:
1. Initialize local git repo (`git init`).
2. Configure user (`Hemang-krishna` / `krishnachaitanyalagadapatihema@gmail.com`).
3. Authenticate with GitHub Personal Access Token via URL (`https://Hemang-krishna:<PAT>@github.com/Hemang-krishna/<repo-name>.git`).
4. Push code to remote repository (`git push -u origin master --force`).
