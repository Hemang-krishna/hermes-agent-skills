#!/bin/bash
# Universal Deploy Script for Netlify & Cloudflare Pages
set -e

if [ -f /data/.env ]; then
    export $(grep -v '^#' /data/.env | xargs)
fi

TARGET=$1
DIR=$2
NAME=${3:-""}

if [ -z "$TARGET" ] || [ -z "$DIR" ]; then
    echo "Usage: deploy <netlify|cloudflare> <directory> [--name=project-name]"
    exit 1
fi

export PATH="/data/deploy_tools/node_modules/.bin:$PATH"

if [ "$TARGET" == "netlify" ]; then
    echo "🚀 Deploying to Netlify..."
    if [ ! -f "$DIR/netlify.toml" ]; then
        echo '[build]' > "$DIR/netlify.toml"
        echo '  command = ""' >> "$DIR/netlify.toml"
        echo '  publish = "."' >> "$DIR/netlify.toml"
    fi
    cd "$DIR"
    netlify deploy --prod --dir="."
elif [ "$TARGET" == "cloudflare" ]; then
    echo "🚀 Deploying to Cloudflare..."
    if [ -n "$NAME" ]; then
        wrangler pages deploy "$DIR" --project-name="$NAME"
    else
        wrangler pages deploy "$DIR"
    fi
else
    echo "Unknown deployment target: $TARGET"
    exit 1
fi
