# GitHub Push Protection (GH013), Secret Sanitization & Multi-Repo Dispatch Reference

## Overview
When pushing large batches of repositories or external tools to GitHub via Personal Access Tokens (PATs), two common failure modes occur:
1. **GitHub Secret Scanning & Push Protection (GH013):** Blocks pushes containing raw API keys, OAuth tokens, or credential strings.
2. **Shallow Clone Unpack Failure (`remote unpack failed: index-pack failed`):** Occurs when attempting to push a shallow-cloned repo (`git clone --depth 1`) directly to a new remote.

---

## 🛡️ 1. Automated Secret Sanitization Pattern
Before committing and pushing any repository, run a regex sanitization pass over source files, HTML, and JSON workflows:

```python
import re, os

def sanitize_repo_secrets(directory_path):
    for root, _, files in os.walk(directory_path):
        for f in files:
            if f.endswith(('.py', '.json', '.html', '.js', '.env', '.md')):
                fpath = os.path.join(root, f)
                try:
                    with open(fpath, 'r', encoding='utf-8', errors='ignore') as file_in:
                        content = file_in.read()
                    
                    # Sanitize OpenAI, Gemini, Notion, and Slack keys
                    cleaned = re.sub(r'sk-[a-zA-Z0-9]{30,}', 'sk-[REDACTED]', content)
                    cleaned = re.sub(r'ntn_[a-zA-Z0-9]{30,}', 'ntn_[REDACTED]', cleaned)
                    cleaned = re.sub(r'AQ\.Ab8RN[a-zA-Z0-9_-]+', 'AQ.Ab8RN-[REDACTED]', cleaned)
                    cleaned = re.sub(r'xox[e-z]-[a-zA-Z0-9_-]+', 'xox-[REDACTED]', cleaned)
                    
                    if cleaned != content:
                        with open(fpath, 'w', encoding='utf-8') as file_out:
                            file_out.write(cleaned)
                except Exception:
                    pass
```

---

## 🔄 2. Resolving Shallow Clone (`git clone --depth 1`) Push Failures
When pushing an external cloned repository to a fresh GitHub URL, avoid pushing shallow history. Instead, copy source files to a clean temporary export folder and re-initialize git:

```python
import shutil, subprocess

def push_clean_copy_to_github(src_dir, repo_name, token, user="Hemang-krishna"):
    clean_dir = f"/tmp/clean_export/{repo_name}"
    shutil.rmtree(clean_dir, ignore_errors=True)
    
    # Copy files ignoring existing .git history and dangling symlinks
    shutil.copytree(
        src_dir, clean_dir,
        symlinks=False,
        ignore_dangling_symlinks=True,
        ignore=shutil.ignore_patterns('.git', '.github', '*.pyc', '__pycache__')
    )
    
    # Sanitize secrets
    sanitize_repo_secrets(clean_dir)
    
    # Git init and force push
    subprocess.run(['git', 'init'], cwd=clean_dir, capture_output=True)
    subprocess.run(['git', 'config', 'user.name', user], cwd=clean_dir, capture_output=True)
    subprocess.run(['git', 'config', 'user.email', 'krishnachaitanyalagadapatihema@gmail.com'], cwd=clean_dir, capture_output=True)
    subprocess.run(['git', 'add', '.'], cwd=clean_dir, capture_output=True)
    subprocess.run(['git', 'commit', '-m', f'Initial release for {repo_name}'], cwd=clean_dir, capture_output=True)
    
    remote_url = f'https://{user}:{token}@github.com/{user}/{repo_name}.git'
    subprocess.run(['git', 'remote', 'add', 'origin', remote_url], cwd=clean_dir, capture_output=True)
    
    res = subprocess.run(['git', 'push', '-u', 'origin', 'master', '--force'], cwd=clean_dir, capture_output=True, text=True)
    return res.stderr or res.stdout
```
