# Netlify & Cloudflare Deployment Engine & Auth Integration

This reference documents automated 1-click deployment patterns, CLI tool management, token authentication, and `browser-use` auth bridge automation for deploying static sites, web apps, and serverless workers to Netlify and Cloudflare.

---

## 1. CLI Tool Setup & Binary Management

Install Netlify CLI (`netlify-cli`) and Cloudflare Wrangler (`wrangler`) locally in node_modules or global workspace:

```bash
mkdir -p /data/deploy_tools
npm install --prefix /data/deploy_tools --no-audit --no-fund netlify-cli wrangler
```

Binaries resolve at:
* Netlify: `/data/deploy_tools/node_modules/.bin/netlify`
* Wrangler: `/data/deploy_tools/node_modules/.bin/wrangler`

---

## 2. 1-Click Deployment Engine Commands

### A. Netlify Deployment Patterns
```bash
# 1. Anonymous Production Deployment (Zero Setup / Instant Preview URL)
mkdir -p /tmp/net_anon
NETLIFY_CONFIG_DIR=/tmp/net_anon NETLIFY_AUTH_TOKEN=*** /data/deploy_tools/node_modules/.bin/netlify deploy --prod --dir=/path/to/build_dir --allow-anonymous

# 2. Authenticated Production Deployment (via NETLIFY_AUTH_TOKEN)
export NETLIFY_AUTH_TOKEN="nfp_..."
# Ensure netlify.toml exists in build dir
if [ ! -f "/path/to/build_dir/netlify.toml" ]; then
    echo '[build]' > "/path/to/build_dir/netlify.toml"
    echo '  command = ""' >> "/path/to/build_dir/netlify.toml"
    echo '  publish = "."' >> "/path/to/build_dir/netlify.toml"
fi

cd /path/to/build_dir
/data/deploy_tools/node_modules/.bin/netlify deploy --prod --dir="."
```

### B. Cloudflare Pages & Workers Deployment Patterns
```bash
# 1. Cloudflare Pages Web App Deployment (requires CLOUDFLARE_API_TOKEN)
export CLOUDFLARE_API_TOKEN="..."
export CLOUDFLARE_ACCOUNT_ID="..."
/data/deploy_tools/node_modules/.bin/wrangler pages deploy /path/to/build_dir --project-name=my-app-name

# 2. Temporary Worker Preview Deployment (Keyless)
/data/deploy_tools/node_modules/.bin/wrangler deploy --temporary
```

---

## 3. Deployment Wrapper Architecture (`/data/deploy_tools/deploy`)

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

## 4. Environment Token Persistence

Persist authentication tokens in `/data/.env` or `~/.hermes/.env` to ensure all future subshell and CLI executions retain deployment capabilities:

```bash
NETLIFY_AUTH_TOKEN=nfp_xxxxxxxxxxxxxxxxxxxx
CLOUDFLARE_API_TOKEN=xxxxxxxxxxxxxxxxxxxx
CLOUDFLARE_ACCOUNT_ID=xxxxxxxxxxxxxxxxxxxx
```
