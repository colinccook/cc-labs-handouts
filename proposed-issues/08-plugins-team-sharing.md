---
title: Package the loop for a team (plugins & shared config)
labels: content-gap,priority:medium
---

**Files:** `*/8-loop-*.md`

## Problem
Ex 8 is "make it *yours*", but there's no step for making it *the team's*. Plugins and marketplaces — which bundle skills, agents, hooks and MCP config — aren't mentioned.

## Why it matters
The workshop's real goal is lasting adoption. A loop that lives in one person's repo spreads slowly; plugins are the current way to share it across repos and teammates. It's a natural follow-on to the existing "teach it to one person" bonus.

## Proposed change
- Bonus: package `/specify`, `reviewer` and `test-gate.sh` as a plugin.
- Explain what belongs in a plugin vs what stays per-repo, and how a teammate installs it.

## Acceptance criteria
- [ ] Plugin bonus in both tracks with a minimal working example.

> _Feature names and flags here move between Claude Code releases — verify against current docs before editing the handouts (see the version-pinning issue)._

_Raised from a course review of current agentic-coding practice._
