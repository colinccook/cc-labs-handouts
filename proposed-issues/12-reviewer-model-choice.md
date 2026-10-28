---
title: Rethink Haiku as the default reviewer model
labels: feedback,priority:medium
---

**Files:** `*/6-agents-*.md`, model note in `README.md` and `*/1-context-*.md`

## Problem
Ex 5 argues review is now the bottleneck and AI-authored code carries more defects per change. Ex 6 then hands review to the cheapest model by default, with a stronger reviewer only as a bonus.

## Why it matters
The message contradicts itself, and learners take the **default** home. A weak reviewer that confidently says "ship" builds exactly the false confidence the course warns against.

## Proposed change
- **Option A:** Sonnet as the default reviewer; Haiku "quick pass" variant as the bonus.
- **Option B:** keep Haiku but move the trade-off into the main text (Haiku for small diffs, stronger model for risky ones).
- Either way, update the "one deliberate exception" wording in the README and Ex 1.

## Acceptance criteria
- [ ] Model choice and its rationale consistent across README and Ex 5–6 in both tracks.

> _Feature names and flags here move between Claude Code releases — verify against current docs before editing the handouts (see the version-pinning issue)._

_Raised from a course review of current agentic-coding practice._
