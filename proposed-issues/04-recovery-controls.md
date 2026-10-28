---
title: Teach recovery controls: interrupt, rewind, compact, resume
labels: content-gap,priority:high
---

**Files:** `*/1-context-*.md` (tips), or a new "controls" box in `README.md`; `*/4-tdd-*.md` (bonus)

## Problem
Nothing covers `Esc` (interrupt), `Esc Esc` / `/rewind` (roll code and conversation back to a checkpoint), `/compact` vs `/clear`, or `/resume` / `--continue`.

## Why it matters
These are the everyday survival skills of agentic work. Learners who know they can rewind will let the agent attempt bolder changes; learners who don't fall back to `git reset` or lose a whole session when it goes wrong. `/compact` is also a cost and context lever that complements the course's existing `/clear` advice — sometimes you want to keep the thread but shed the bulk.

## Proposed change
- Extend the existing "Know your controls" tip in Ex 1 (currently `/model`, `/effort`, `ultrathink`) with the four controls above.
- Ex 4 bonus: deliberately let Claude take a wrong turn, then `/rewind` it.

## Acceptance criteria
- [ ] All four controls introduced in both tracks.
- [ ] At least one hands-on `/rewind`.

> _Feature names and flags here move between Claude Code releases — verify against current docs before editing the handouts (see the version-pinning issue)._

_Raised from a course review of current agentic-coding practice._
