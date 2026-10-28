---
title: Define "non-trivial" in the spec-first rule
labels: feedback,priority:low
---

**Files:** `*/2-spec-*.md` (step 5 rule), `*/8-loop-*.md`

## Problem
`workflow.md` says *"for any non-trivial feature, propose a spec and STOP"* without defining non-trivial. Ex 8 later says "match the loop's weight to the risk", but that never makes it into the rule itself.

## Why it matters
A vague rule is applied inconsistently: Claude either specs one-line fixes (ceremony that makes people abandon the loop) or skips specs for risky changes (the failure the rule exists to prevent).

## Proposed change
Add concrete triggers to the rule prompt, e.g. new user-facing behaviour, more than ~2 files, data/schema changes, public API changes, anything needing an ADR. State that bug fixes with a reproducing test may skip the spec.

## Acceptance criteria
- [ ] Rule prompt includes the criteria in both tracks.
- [ ] Ex 8 guidance matches.

> _Feature names and flags here move between Claude Code releases — verify against current docs before editing the handouts (see the version-pinning issue)._

_Raised from a course review of current agentic-coding practice._
