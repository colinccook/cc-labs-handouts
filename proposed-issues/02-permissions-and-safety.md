---
title: Add permissions & safety basics (modes, allow/deny rules, sandbox)
labels: content-gap,security,priority:high
---

**Files:** `greenfield/7-hooks-greenfield.md`, `brownfield/7-hooks-brownfield.md`, optionally `README.md`

## Problem
Ex 7 says the hook's `if` is *"not security — that's what the permission system is for"*, but the permission system is never taught. Missing: permission modes (default / accept edits / plan / auto / bypass), `permissions.allow` / `deny` / `ask` in `.claude/settings.json`, project vs local vs user settings, and sandboxing.

## Why it matters
After a day and a half of approval prompts, the most likely thing a learner does on Monday is reach for `--dangerously-skip-permissions`. Teaching scoped allow rules (allow the test command; deny `rm -rf`, reading `.env`, etc.) gives them a **safe** way to reduce friction instead of an unsafe one. It also finishes the thought Ex 7 starts — right now the handout points at a guardrail it never shows.

## Proposed change
- In Ex 7, add a step that commits `allow` and `deny` rules alongside the hook.
- Explain **hook vs permission rule**: hooks run checks and give feedback; permission rules are the hard allow/deny boundary.
- Briefly cover permission modes and when each fits.
- Mention sandboxing as the safe route to unattended or bypass-mode runs.
- Clarify `settings.json` (committed, team) vs `settings.local.json` (personal) vs `~/.claude/settings.json` (user).

## Acceptance criteria
- [ ] Learners commit at least one `deny` rule (e.g. reading `.env`).
- [ ] Hook vs permission rule is explained in both tracks.
- [ ] Bypass mode is explicitly framed as sandbox-only.

> _Feature names and flags here move between Claude Code releases — verify against current docs before editing the handouts (see the version-pinning issue)._

_Raised from a course review of current agentic-coding practice._
