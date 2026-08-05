---
name: web-deployment
description: Deploy static sites, frontend web apps, and serverless backends to Netlify and Cloudflare Pages/Workers via CLI and environment tokens.
---

# Web Deployment (Netlify, Cloudflare, Vercel, Firebase, Heroku)

A class-level skill for building and deploying static sites, web applications, and serverless backends to 5 major cloud providers using CLI tools (`netlify`, `wrangler`, `vercel`, `firebase`, `heroku`).

---

## 🛠️ Prerequisites & Authentication

Store credentials in `/data/.env` or system environment variables:

* **Netlify:** `NETLIFY_AUTH_TOKEN` (Personal Access Token starting with `nfp_...`)
* **Cloudflare:** `CLOUDFLARE_API_TOKEN` and `CLOUDFLARE_ACCOUNT_ID`
* **Vercel:** `VERCEL_TOKEN`
* **Firebase:** `FIREBASE_TOKEN`
* **Heroku:** `HEROKU_API_KEY`

---

## 🚀 Core Workflows

### 1. Vercel Deployment (`vercel`)

```bash
# Load token and deploy to production
export VERCEL_TOKEN=$(grep VERCEL_TOKEN /data/.env | cut -d'=' -f2)
cd /path/to/dist
vercel deploy --prod --token="$VERCEL_TOKEN" --yes
```

### 2. Firebase Hosting Deployment (`firebase-tools`)

```bash
# Ensure firebase.json exists
cat << 'EOF' > firebase.json
{
  "hosting": {
    "public": ".",
    "ignore": ["firebase.json", "**/.*", "**/node_modules/**"]
  }
}
EOF

# Deploy
firebase deploy --only hosting --token "$FIREBASE_TOKEN"
```

### 3. Heroku Container / Dyno Deployment (`heroku`)

```bash
# Set app remote and push
heroku git:remote -a my-app-name || heroku create my-app-name
git push heroku main
```

---

## 🚀 Core Workflows

### 1. Netlify Deployment (`netlify-cli`)

Deploy pre-built static directory to Netlify production:

```bash
# Load environment token
export $(grep -v '^#' /data/.env | xargs)

# Navigate to build directory
cd /path/to/dist

# Ensure netlify.toml exists to prevent remote build command guessing
if [ ! -f "netlify.toml" ]; then
    echo '[build]' > netlify.toml
    echo '  command = ""' >> netlify.toml
    echo '  publish = "."' >> netlify.toml
fi

# Deploy to production
netlify deploy --prod --dir="."
```

### 2. Anonymous / Keyless Netlify Deployment

Deploy without a token or account using `--allow-anonymous`:

```bash
# Isolate config dir to prevent conflicts with cached user logins
mkdir -p /tmp/net_anon
NETLIFY_CONFIG_DIR=/tmp/net_anon NETLIFY_AUTH_TOKEN="" netlify deploy --prod --dir="/path/to/dist" --allow-anonymous
```

### 3. Cloudflare Pages Deployment (`wrangler`)

Deploy pre-built static directory to Cloudflare Pages:

```bash
# Load environment token
export $(grep -v '^#' /data/.env | xargs)

# Deploy pages project
wrangler pages deploy /path/to/dist --project-name=my-app-name
```

---

## ⚡ Automated 1-Click Deployment Script Template

Use a wrapper script (e.g. `/data/deploy_tools/deploy`) to standardize deployments across tools and ensure auto-injection of `netlify.toml`:

```bash
#!/bin/bash
set -e

if [ -f /data/.env ]; then
    export $(grep -v '^#' /data/.env | xargs)
fi

TARGET=$1
DIR=$2
NAME=${3:-""}

export PATH="/data/deploy_tools/node_modules/.bin:$PATH"

if [ "$TARGET" == "netlify" ]; then
    if [ ! -f "$DIR/netlify.toml" ]; then
        echo '[build]' > "$DIR/netlify.toml"
        echo '  command = ""' >> "$DIR/netlify.toml"
        echo '  publish = "."' >> "$DIR/netlify.toml"
    fi
    cd "$DIR"
    netlify deploy --prod --dir="."
elif [ "$TARGET" == "cloudflare" ]; then
    wrangler pages deploy "$DIR" --project-name="$NAME"
fi
```

---

## ⚠️ Critical Pitfalls & Fixes

### 4. Dynamic Full-Stack Backend Services vs. Static Hosting
* **Symptom:** User complains that static hosting (Netlify static, Cloudflare Pages static) does not support active Python/Node.js backend execution, background processes, or SQLite updates.
* **Root Cause:** Static edge hosting only serves HTML/JS/CSS assets and cannot execute long-lived server processes or persistent database writes.
* **Fix:** Expose the local full-stack server (`FastAPI`, `Express`, `SQLite`) using an automated public HTTPS tunnel (`localtunnel` / `cloudflared`) with CORS middleware (`CORSMiddleware`) enabled, or deploy to dynamic serverless environments (Vercel Functions / Cloudflare Workers Functions). To ensure 24/7 $0.00 uptime, pair with an automated 5-minute cron watchdog (`tunnel_watchdog.sh`) that checks endpoint health (`HTTP 200`) and auto-restarts backend/tunnel processes if dropped.

### 1. Netlify Remote Build Command Failure (`hugo: command not found` / `npm: command not found`)
* **Symptom:** Running `netlify deploy --prod` fails during build stage with missing build tool error.
* **Root Cause:** Netlify CLI reads project settings from Netlify UI or auto-detects a framework and tries to run a remote build command (e.g. `hugo`).
* **Fix:** Ensure a local `netlify.toml` exists in the publish directory setting `command = ""` before running deploy:
  ```toml
  [build]
    command = ""
    publish = "."
  ```

### 2. Unauthorized Error (`JSONHTTPError: Unauthorized`)
* **Symptom:** `netlify deploy` returns `401 Unauthorized` even with a valid token set.
* **Root Cause:** The directory contains a stale `.netlify/state.json` linking it to an anonymous or different team project ID.
* **Fix:** Remove the stale state directory (`rm -rf .netlify`) before re-deploying with the new authenticated account.

### 3. Anonymous Deploy Fails with `No project linked`
* **Symptom:** Passing `--allow-anonymous` fails when cached credentials exist in `~/.config/netlify/config.json`.
* **Fix:** Set `NETLIFY_CONFIG_DIR=/tmp/net_anon` and `NETLIFY_AUTH_TOKEN=""` to isolate the session.

