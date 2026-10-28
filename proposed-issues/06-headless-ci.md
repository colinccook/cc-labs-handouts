---
title: Add headless Claude in CI (claude -p, GitHub Action, PR review)
labels: content-gap,priority:medium
---

**Files:** `*/7-hooks-*.md` (the CI note), `*/8-loop-*.md`

## Problem
Ex 7 says *"CI is still what holds the bar"* and the loop ends at a PR, but the course never shows Claude running without a human: `claude -p`, the Claude Code GitHub Action, `@claude` mentions, or automated PR review.

## Why it matters
This is where most teams go next after adopting a local loop. It closes the gap where nothing gates the PR (see the PR-gate issue), and it shows the learner's own reviewer prompt and skills being reused outside the terminal — reinforcing that the artifacts they built are portable, not workshop-only.

## Proposed change
- Ex 8 "next step": one `claude -p` command that runs the reviewer prompt against the current diff.
- Optional: install the GitHub Action so PRs get an automated review and CI runs the same coverage command as the hook.

## Acceptance criteria
- [ ] Both tracks show `claude -p` with the reviewer.
- [ ] A CI workflow example runs the same coverage command as the hook.
- [ ] Security note on secrets and permissions in CI.

> _Feature names and flags here move between Claude Code releases — verify against current docs before editing the handouts (see the version-pinning issue)._

_Raised from a course review of current agentic-coding practice._
