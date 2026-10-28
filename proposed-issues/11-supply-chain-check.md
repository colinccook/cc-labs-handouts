---
title: Add a supply-chain check to review (hallucinated / typo-squatted packages)
labels: content-gap,security,priority:medium
---

**Files:** `*/5-review-*.md`, `*/6-agents-*.md` (reviewer prompt)

## Problem
Neither the by-hand review prompt nor the reviewer agent checks new dependencies.

## Why it matters
Agents sometimes add packages that don't exist or are lookalikes of real ones, and attackers register those names ("slopsquatting"). Greenfield learners add many dependencies quickly in a short window — the highest-risk moment — and the review step is the natural place to catch it.

## Proposed change
- Add *"new or changed dependencies: does each exist, is it the intended package, is it maintained, is it pinned?"* to the review prompt and reviewer agent body.
- Optional: an `ask` / `deny` permission rule on install commands (links to the permissions issue).

## Acceptance criteria
- [ ] Review prompt and reviewer agent in both tracks include the dependency check.

> _Feature names and flags here move between Claude Code releases — verify against current docs before editing the handouts (see the version-pinning issue)._

_Raised from a course review of current agentic-coding practice._
