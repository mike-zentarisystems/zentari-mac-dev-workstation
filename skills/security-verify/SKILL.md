# Security Verification

Apply checks proportionally to the change.

- Gitleaks: repository secret exposure.
- Semgrep: source-level security patterns.
- OSV-Scanner: dependency vulnerability exposure.
- Trivy: container/image and filesystem vulnerability checks.

For authentication, authorization, secrets, input handling, file upload, network boundaries, dependency or infrastructure changes, also review trust boundaries, failure behavior and least privilege.

Never weaken a security control merely to make a test pass. Never print secrets into verification output.
