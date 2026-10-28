---
title: Reconsider the global 90% coverage gate for greenfield
labels: feedback,priority:low
---

**Files:** `greenfield/7-hooks-greenfield.md`

## Problem
Greenfield enforces a global 90% line-coverage gate on a 1.5-day prototype, while the same handout warns against "coverage theatre".

## Why it matters
On a fast prototype, a hard 90% pushes learners — and Claude — into writing tests just to move the number. Commits getting blocked late in the day also risks learners blaming the tool rather than learning from it.

## Proposed change
Either lower the global bar (e.g. 80%) or use 90% on changed lines as brownfield does — keeping the "cheap now, expensive later" argument as the stated rationale.

## Acceptance criteria
- [ ] Threshold choice justified in the text.
- [ ] Consistent with the coverage-theatre warning.

> _Feature names and flags here move between Claude Code releases — verify against current docs before editing the handouts (see the version-pinning issue)._

_Raised from a course review of current agentic-coding practice._
