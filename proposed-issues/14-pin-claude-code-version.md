---
title: Record the tested Claude Code version and recheck fast-moving claims
labels: maintenance,priority:high
---

**Files:** `README.md`, all exercises

## Problem
The handouts depend on details that change between releases:
- hook `if` field and its fail-open behaviour; default hook timeout
- `claude --worktree`, `.worktreeinclude`, `WorktreeCreate` / `WorktreeRemove` hooks
- `/effort` levels and `effort:` in skill frontmatter
- built-ins `/simplify`, `/code-review low`, `/security-review`
- `prompt` / `agent` hook types

## Why it matters
One broken command in a live workshop costs the whole room time and the course its credibility. A recorded version makes drift detectable and tells facilitators exactly what to recheck before each delivery.

## Proposed change
- Add *"Tested with Claude Code vX.Y on <date>"* to the README.
- Keep a checklist (in-repo or in this issue) of version-sensitive claims to recheck before each run.

## Acceptance criteria
- [ ] Version line present.
- [ ] Checklist committed.
- [ ] Every listed claim rechecked against current docs.

> _Feature names and flags here move between Claude Code releases — verify against current docs before editing the handouts (see the version-pinning issue)._

_Raised from a course review of current agentic-coding practice._
