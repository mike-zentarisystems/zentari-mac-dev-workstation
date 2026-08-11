# Browser Verification

Use for web UI and browser-visible behavior.

1. Start the application using its documented command.
2. Confirm the target URL responds.
3. Use Playwright MCP for exploratory agent verification.
4. Use repository Playwright Test for durable regression coverage.
5. Exercise the changed user journey, not just page load.
6. Check browser console errors and failed network requests.
7. Verify important loading, empty, error and success states.
8. Run axe accessibility checks for changed user-facing flows when configured.
9. For RELEASE verification, exercise Chromium, Firefox and WebKit when the project supports them.
10. Capture enough evidence to identify the tested route, scenario and result.

A visual appearance that looks correct is not sufficient proof of functional behavior.
