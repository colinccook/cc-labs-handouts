---
title: Mention AGENTS.md for repos used with multiple coding tools
labels: content-gap,priority:low
---

**Files:** `*/1-context-*.md`

## Problem
The course only covers `CLAUDE.md`.

## Why it matters
`AGENTS.md` is a widely adopted convention shared across coding agents. Brownfield learners may already have one, or have teammates on other tools. Without guidance they'll end up maintaining two instruction files that drift apart — undermining the "thin, single source" principle Ex 1 teaches.

## Proposed change
Ex 1 tip: if the repo has (or needs) `AGENTS.md`, keep shared rules there and import it from `CLAUDE.md` with `@AGENTS.md`; keep Claude-specific content in `CLAUDE.md`.

## Acceptance criteria
- [ ] Tip present in both tracks.
- [ ] Brownfield's `/init` step checks for an existing `AGENTS.md`.

> _Feature names and flags here move between Claude Code releases — verify against current docs before editing the handouts (see the version-pinning issue)._

_Raised from a course review of current agentic-coding practice._
