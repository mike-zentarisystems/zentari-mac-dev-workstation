# M1 Runbook: Local AI Coding Loop

M1 is complete only after the configuration is validated on the target M4 Mac. Repository changes alone cannot prove local model performance or memory pressure.

## 1. Update the workstation

```bash
git fetch origin
git switch m1-local-ai-coding-loop
chmod +x scripts/m1-validate.sh
./bootstrap.sh
```

## 2. Start OrbStack

Open OrbStack and verify:

```bash
docker info
docker run --rm hello-world
```

## 3. Start LM Studio

Load exactly one target model and start the local server. Verify:

```bash
curl -s http://localhost:1234/v1/models | python3 -m json.tool
```

For the 24 GB M4, start with the context recommendations in `docs/MODELS.md`. Watch macOS Activity Monitor Memory Pressure and Swap Used while benchmarking.

## 4. Validate dependencies

```bash
./scripts/m1-validate.sh
```

Every integration line should report PASS. The script intentionally fails when a required component is unavailable.

## 5. Install OpenCode configuration safely

Do not overwrite an existing OpenCode configuration without review. Compare `opencode/opencode.json` with your current configuration, then merge the `lmstudio` provider and `playwright` MCP blocks.

Verify OpenCode can:

1. Read the repository.
2. Run `git status`.
3. Use the LM Studio model.
4. See Playwright MCP tools.

## 6. Zed ACP

Follow `docs/ZED.md`, open this repository in Zed, start an OpenCode ACP session, and ask it to inspect the repository without changing files. Confirm the agent reports the actual repository structure.

## 7. Benchmark each model

Run one model at a time:

```bash
python3 scripts/benchmark-lmstudio.py | tee benchmark-qwen.txt
```

Repeat for the general/vision and reviewer models. Record exact model/build, quantization, context allocation, elapsed time, effective tokens/sec when reported, Memory Pressure, peak memory and Swap Used.

Do not compare models while another large model remains loaded.

## 8. M1 acceptance test

Use a disposable test repository or branch. Give OpenCode this task:

> Investigate this repository first. Add one small behavior with tests. Follow existing patterns. Run the applicable verification. Use Playwright when browser behavior changes. Do not declare completion without command evidence.

M1 passes when OpenCode can complete the loop from Zed using the local coding model:

`investigate -> plan -> edit -> test -> verify -> review diff`

and Playwright MCP is available for browser work.

## 9. Record results

Copy `docs/M1-VALIDATION-TEMPLATE.md` to a dated validation report and fill in measured results. Do not mark hardware-dependent roadmap items complete until the Mac validation has actually run.
