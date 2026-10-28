---
title: Expand parallel / multi-agent patterns beyond a single reviewer
labels: content-gap,priority:medium
---

**Files:** `*/6-agents-*.md`, `*/8-loop-*.md`, brownfield `1-context` / `2-spec`

## Problem
Ex 6 teaches exactly one subagent (the reviewer). Worktrees are a bonus; the built-in **Explore** subagent, fanning work out to several subagents, and background/cloud agents aren't mentioned.

## Why it matters
Running agents in parallel is one of the biggest current productivity patterns. The Explore subagent is especially valuable on brownfield: it can read a large, unfamiliar codebase and return a summary without flooding the main context — exactly the context-budget discipline the course teaches elsewhere.

## Proposed change
- Brownfield Ex 1 or 2: use Explore to map the area a feature touches before writing the spec.
- Ex 6 bonus: run two subagents in parallel (e.g. spec reviewer + security reviewer).
- Ex 8: promote worktrees to a short guided step; mention background and cloud agents.

## Acceptance criteria
- [ ] Explore used in brownfield.
- [ ] A parallel-agent example in both tracks.
- [ ] Worktree cleanup guidance retained.

> _Feature names and flags here move between Claude Code releases — verify against current docs before editing the handouts (see the version-pinning issue)._

_Raised from a course review of current agentic-coding practice._
