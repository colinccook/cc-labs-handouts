---
title: Reviewer agent is described as read-only but has Bash
labels: bug,security,priority:medium
---

**Files:** `greenfield/6-agents-greenfield.md`, `brownfield/6-agents-brownfield.md`

## Problem
Ex 6 calls the reviewer "read-only" because Write/Edit are omitted, but `tools:` includes `Bash`. With Bash it can still mutate files or repo state (`sed -i`, `git checkout`, `git stash`, `rm`, redirects).

## Why it matters
This is a factually wrong safety claim in teaching material. Learners will reuse the pattern for agents they trust more, believing tool omission alone makes them safe.

## Proposed change
- **Option A:** reword to *"no Edit/Write, so it won't deliberately rewrite code — Bash can still change files."*
- **Option B (preferred):** actually restrict it — pass the diff in, or use permission rules / a `PreToolUse` hook that only allows `git diff`, `git log`, `git status`. Nice reuse of Ex 7.

## Acceptance criteria
- [ ] No handout claims "read-only" unless it's enforced.
- [ ] Both tracks updated.

> _Feature names and flags here move between Claude Code releases — verify against current docs before editing the handouts (see the version-pinning issue)._

_Raised from a course review of current agentic-coding practice._
