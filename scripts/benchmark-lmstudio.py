#!/usr/bin/env python3
"""Small repeatable benchmark for the model currently loaded in LM Studio."""
import json
import os
import time
import urllib.request

BASE = os.getenv("LMSTUDIO_URL", "http://localhost:1234/v1")
PROMPT = """You are modifying a production Python service. Write a Python function named
parse_port(value) that accepts int or string input, returns an integer TCP port from 1 through
65535, rejects booleans, whitespace-only strings, floats, and out-of-range values with
ValueError. Include concise pytest tests. Return code only."""

models = json.load(urllib.request.urlopen(f"{BASE}/models", timeout=5)).get("data", [])
if not models:
    raise SystemExit("No model is exposed by LM Studio. Load a model first.")
model = models[0]["id"]

payload = json.dumps({
    "model": model,
    "messages": [{"role": "user", "content": PROMPT}],
    "temperature": 0.1,
    "max_tokens": 1200,
}).encode()
req = urllib.request.Request(
    f"{BASE}/chat/completions", data=payload,
    headers={"Content-Type": "application/json"}, method="POST"
)
start = time.perf_counter()
with urllib.request.urlopen(req, timeout=180) as response:
    result = json.load(response)
elapsed = time.perf_counter() - start
usage = result.get("usage", {})
out = result["choices"][0]["message"]["content"]
completion = usage.get("completion_tokens")

print(f"model: {model}")
print(f"elapsed_seconds: {elapsed:.2f}")
if completion:
    print(f"completion_tokens: {completion}")
    print(f"effective_tokens_per_second: {completion / elapsed:.2f}")
print("\n--- response ---\n")
print(out)
