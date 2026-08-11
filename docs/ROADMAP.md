# Roadmap

## M0 - Foundation

- [x] Initialize repository
- [x] Add Brewfile
- [x] Add non-destructive bootstrap
- [x] Add workstation doctor
- [x] Add core agent skills
- [x] Add OpenCode + Playwright MCP template
- [x] Add LM Studio model guidance
- [x] Add Zed/ACP setup guide
- [x] Add verification scripts
- [x] Add GitHub Actions verification template
- [x] Add OrbStack clean-room test dependency template

**Status: COMPLETE**

## M1 - Local AI Coding Loop

- [x] Add M1 integration validation script
- [x] Add repeatable LM Studio benchmark harness
- [x] Expand repository investigation and implementation skills
- [x] Add end-to-end M1 runbook and measured validation template
- [ ] Zed + OpenCode ACP integration validated on the target Mac
- [ ] LM Studio provider configuration validated on the target Mac
- [ ] Coding/general/reviewer model presets benchmarked on the 24 GB M4
- [ ] JIT load and single-large-model memory policy validated under real memory pressure
- [ ] End-to-end local coding acceptance test passed

**Status: IMPLEMENTED, HARDWARE VALIDATION REQUIRED**

## M2 - Verification Harness

- [ ] FAST/FULL/RELEASE verification profiles hardened against multiple project types
- [ ] Playwright Test + MCP project template
- [ ] axe accessibility checks
- [ ] Gitleaks, Semgrep, OSV-Scanner, Trivy policy tuning
- [ ] OrbStack clean-room integration runner
- [ ] production-artifact verification

## M3 - Adversarial and Failure Testing

- [ ] reviewer-model workflow
- [ ] edge-case verification
- [ ] failure-mode testing
- [ ] API contract testing
- [ ] optional property and mutation testing

## M4 - Reusable Project Bootstrap

- [ ] project templates
- [ ] per-repository skills
- [ ] CI templates
- [ ] Docker test dependencies
- [ ] one-command project onboarding
