# Zed + OpenCode

Zed is the editor/cockpit. OpenCode is the coding agent. LM Studio remains the replaceable inference layer.

## Setup

1. Install and open Zed.
2. Open the Agent Panel.
3. Add OpenCode from the ACP agent registry when available in your Zed build.
4. Open the repository you want to work on.
5. Start LM Studio and load the desired local model.
6. Start the LM Studio local server on port 1234.
7. Verify `curl -fsS http://localhost:1234/v1/models` returns successfully.
8. Confirm OpenCode can see the repository and run a harmless command such as `git status`.

## Responsibility boundaries

- Zed: editing, navigation, terminal, Git UI.
- OpenCode: investigate, plan, implement, invoke tools and verification.
- LM Studio: local inference only.
- OrbStack: Docker runtime and disposable test infrastructure.
- Playwright: browser verification.
- GitHub Actions: independent CI verification.

Do not put OpenCode or LM Studio inside OrbStack. They need first-class access to macOS and the working repository.
