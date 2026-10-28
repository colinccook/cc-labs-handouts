---
title: Promote MCP from "explore on your own" into the main path
labels: content-gap,priority:high
---

**Files:** `*/8-loop-*.md`, and Ex 4 if combined with the verification issue

## Problem
MCP only appears as a pointer ("further layers still to explore on your own") and a Jira aside in Ex 2.

## Why it matters
MCP is now the standard way agents reach real systems — browsers, documentation, issue trackers, databases. Leaving it out entirely means learners miss the extension point they're most likely to need next. One well-chosen server shows the idea without much setup cost, and a docs server (e.g. Context7) directly reduces invented or outdated APIs — a common failure mode.

## Proposed change
- One guided MCP install, e.g. Playwright (pairs with the verification issue) or a docs server.
- Use `claude mcp add` with project scope so it ships with the repo.
- Show the context cost of tool definitions via `/context`.
- Cross-link the prompt-injection / trust note.

## Acceptance criteria
- [ ] One MCP server installed and actually used in both tracks.
- [ ] Context cost shown.
- [ ] Trust/security note present.

> _Feature names and flags here move between Claude Code releases — verify against current docs before editing the handouts (see the version-pinning issue)._

_Raised from a course review of current agentic-coding practice._
