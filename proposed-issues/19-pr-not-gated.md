---
title: The loop ends in a PR, but nothing gates the PR
labels: feedback,priority:low
---

**Files:** `README.md`, `*/7-hooks-*.md`, `*/8-loop-*.md`

## Problem
The README promises *spec → build → test → review → commit/PR*. The hook gates only commits made through Claude Code; hand-made commits and the PR itself are never checked (Ex 7 admits this).

## Why it matters
The loop's headline promise — "green isn't a judgement call" — stops at the most important handoff, the point where teammates actually see the change.

## Proposed change
- Close it via the headless-CI issue: a CI workflow running the same coverage command, plus optional automated PR review.
- Optionally the `git push` gate (already an Ex 7 bonus).
- Update the README so it doesn't overstate the guarantee.

## Acceptance criteria
- [ ] Both tracks show a PR-level check.
- [ ] README wording matches what's actually enforced.

> _Feature names and flags here move between Claude Code releases — verify against current docs before editing the handouts (see the version-pinning issue)._

_Raised from a course review of current agentic-coding practice._
