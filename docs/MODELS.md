# LM Studio Models

LM Studio runs natively on macOS and exposes an OpenAI-compatible endpoint at `http://localhost:1234/v1`.

## M4 24 GB policy

Run one large model at a time. Prefer MLX 4-bit builds when available, enable Metal acceleration, and leave enough unified memory for macOS, Zed, OpenCode, browser verification, and OrbStack.

| Role | Model | Starting context | Purpose |
|---|---|---:|---|
| General / vision | Gemma 4 12B | 64K | chat, reasoning, screenshots/images |
| Primary coding | Qwen3-Coder 30B-A3B | 64K target | implementation, repository work, tools |
| Reviewer / escalation | Ornith 35B | 32K-48K | adversarial review and difficult reasoning |

Model names vary by downloaded build. OpenCode therefore targets `local-model`, meaning the model currently loaded in LM Studio.

## Operating rules

1. Only one large model loaded at a time.
2. Start below the theoretical maximum context and increase only after measuring memory pressure and generation speed.
3. Use the coding model for normal implementation.
4. Use the reviewer model after tests pass for important changes.
5. Use the general/vision model for visual inspection and non-coding work.
6. Never trade system stability for unused maximum context.
