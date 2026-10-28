---
title: Teach Claude to verify its work beyond unit tests (browser / running app)
labels: content-gap,priority:high
---

**Files:** `greenfield/4-tdd-greenfield.md`, `brownfield/4-tdd-brownfield.md`, `greenfield/8-loop-greenfield.md`, `brownfield/8-loop-brownfield.md`

## Problem
The only "done" signal in the course is unit tests (Ex 4) plus a coverage gate (Ex 7). Claude never runs the app, drives a browser, takes a screenshot, or hits its own endpoints.

## Why it matters
Current guidance — including Anthropic's *Best practices for Claude Code*, which Ex 8 already links — treats "give the agent a way to verify its own output" as the single highest-leverage practice. Unit tests can be green while the UI is broken, a route returns 500, or the layout collapses. Greenfield projects almost always have a UI or API, so learners will hit this on day one back at work. Without it, the loop's promise that "done means *proven*" only covers the logic layer.

## Proposed change
- Add a **"prove it running"** step in Ex 4 (or as a main-path item in Ex 8): start the app, use the Playwright or Chrome DevTools MCP to walk each acceptance criterion, screenshot the result.
- Provide a fallback for API-only / CLI stacks (`curl` / HTTP smoke test / running the binary).
- Frame it explicitly: *tests prove the logic; a running check proves the feature.*

## Acceptance criteria
- [ ] Both tracks include a verification step against the running app.
- [ ] A non-UI fallback is documented.
- [ ] The step is tied back to the spec's acceptance criteria.
- [ ] Pairs with the MCP issue (one install serves both).

> _Feature names and flags here move between Claude Code releases — verify against current docs before editing the handouts (see the version-pinning issue)._

_Raised from a course review of current agentic-coding practice._
