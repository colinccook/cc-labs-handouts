---
title: Reduce drift between greenfield and brownfield tracks
labels: maintenance,priority:medium
---

**Files:** `greenfield/*`, `brownfield/*`

## Problem
16 near-duplicate files. Shared blocks — default-model note, token-smart notes, hook JSON, exit-code tips, further reading — are copied by hand into both tracks.

## Why it matters
Every fix must be made twice, and missed edits silently make the tracks disagree. Nearly every other issue in this batch touches both tracks, so the risk compounds with each change.

## Proposed change
Pick one:
- (a) one file per exercise with track-specific callouts;
- (b) shared partials plus a small build step;
- (c) a CI check that diffs sections marked as shared.

## Acceptance criteria
- [ ] Chosen approach documented.
- [ ] Shared content has a single source, or is checked automatically.

> _Feature names and flags here move between Claude Code releases — verify against current docs before editing the handouts (see the version-pinning issue)._

_Raised from a course review of current agentic-coding practice._
