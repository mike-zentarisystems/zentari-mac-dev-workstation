# Verify Work

## Purpose
Prove that a change works before declaring it complete.

## Rules
Never claim a check passed unless it actually ran and returned a successful result. Never silently skip a required check. Report unavailable checks explicitly.

## Procedure
1. Inspect repository-native scripts and CI before inventing commands.
2. Run formatting or formatting check.
3. Run linting.
4. Run static/type checks when applicable.
5. Run affected unit tests.
6. Run integration tests when behavior or boundaries changed.
7. Run the production build when build output can change.
8. For UI changes, use Playwright against the running application and inspect console errors and failed requests.
9. Run accessibility checks for user-facing UI changes.
10. Run security/dependency/container checks when applicable.
11. Review `git diff` for unintended changes, secrets, debug code, generated junk, and scope creep.
12. Record what ran, what passed, what failed, and what could not run.

## Verification levels
- FAST: format, lint, types, affected tests.
- FULL: FAST plus test suite, integration, production build, browser/accessibility where applicable, Gitleaks and Semgrep.
- RELEASE: FULL plus OSV, production container build, Trivy, clean-environment integration, contracts, cross-browser and failure testing where applicable.
