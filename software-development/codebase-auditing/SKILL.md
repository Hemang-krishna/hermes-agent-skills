---
name: codebase-auditing
description: "Framework and patterns for auditing codebases, identifying security vulnerabilities, hardware lock-ins, and race conditions, and applying verified fixes."
version: 1.0.0
metadata:
  hermes:
    tags: [security-audit, code-review, vulnerabilities, hardware-fallbacks, refactoring]
---

# Codebase Auditing & Security Patching

This skill provides a systematic framework for auditing external or legacy codebases, ranking findings by severity, and applying clean, verified patches for security, portability, and correctness.

## Audit Workflow

1. **Full-Spectrum Code & Dependency Inspection**
   - Read all execution scripts, dataloaders, tokenizer setups, and configuration files rather than relying solely on high-level documentation.
   - Scan for security vulnerabilities (e.g. unsafe deserialization, shell injection), hardware assumptions (e.g. CUDA/Hopper hardcodes), and race conditions.

2. **Severity Classification Matrix**
   - **CRITICAL (9.0–10.0):** Remote Code Execution (RCE), unauthenticated execution, hardware hard-crashes.
   - **HIGH (7.5–8.9):** Data corruption, file-download race conditions, metric skew.
   - **MEDIUM (5.0–7.4):** Performance bottlenecks ($O(N)$ operations in loops), memory leaks, distorted statistics.
   - **LOW (1.0–4.9):** Dead code, unused imports/functions, unsanitized prompt text.

3. **Proven Security & Portability Fix Patterns**

### A. Replacing Insecure `pickle` Deserialization with JSON
Replace `pickle.dump()` / `pickle.load()` with structured JSON serialization to eliminate RCE risks:
```python
# Serialization (convert bytes keys to hex strings)
tok_data = {
    "pat_str": pattern,
    "mergeable_ranks": {k.hex(): v for k, v in mergeable_ranks.items()},
    "special_tokens": special_tokens
}
import json
with open("tokenizer.json", "w", encoding="utf-8") as f:
    json.dump(tok_data, f, indent=2)

# Deserialization (reconstruct bytes keys)
with open("tokenizer.json", "r", encoding="utf-8") as f:
    data = json.load(f)
mergeable_ranks = {bytes.fromhex(k): v for k, v in data["mergeable_ranks"].items()}
```

### B. Hardware-Agnostic Fallbacks (e.g. FlashAttention -> SDPA)
Avoid hard crashing on non-supported hardware (e.g. non-Hopper GPUs or CPU/MPS) by falling back to PyTorch native functions:
```python
if fa3 is not None:
    y = fa3.flash_attn_func(q, k, v, causal=True, window_size=window_size)
else:
    # PyTorch scaled_dot_product_attention fallback
    q_t, k_t, v_t = q.transpose(1, 2), k.transpose(1, 2), v.transpose(1, 2)
    y = F.scaled_dot_product_attention(q_t, k_t, v_t, is_causal=True).transpose(1, 2)
```

### C. PID-Scoped Atomic File Downloads
Prevent multi-worker file corruption during parallel data downloads:
```python
temp_path = f"{filepath}.tmp.{os.getpid()}"
with open(temp_path, "wb") as f:
    f.write(chunk)
os.replace(temp_path, filepath) # Atomic rename prevents partial reads
```

### D. Dynamic Hardware Metric Sensing
Avoid hardcoded hardware constants (e.g. H100 peak FLOPS) that distort performance metrics on other devices:
```python
def get_peak_flops():
    if not torch.cuda.is_available():
        return 100e12
    device_name = torch.cuda.get_device_name().lower()
    if "h100" in device_name:
        return 989.5e12
    elif "4090" in device_name:
        return 330.0e12
    return 150.0e12
```

4. **Automated Fix Verification**
   - Always create a dedicated verification script or test suite validating that all patches execute without error and maintain backward compatibility.
