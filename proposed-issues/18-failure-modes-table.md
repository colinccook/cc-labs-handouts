---
title: Add a consolidated "agent failure modes" reference
labels: content-gap,priority:low
---

**Files:** `*/8-loop-*.md` or `README.md`

## Problem
Failure modes are mentioned only in passing across exercises: context rot, hallucinated APIs, scope creep, weakening tests to pass, defending its own code, ignoring rules.

## Why it matters
A single "what goes wrong → which part of the loop catches it" table turns scattered warnings into something learners can use, and maps directly onto Ex 8's *"did the loop catch it?"* question. It also makes the *why* of each loop step memorable.

## Proposed change
Add a table to Ex 8: failure mode · symptom · guard in the loop (spec, RED test, fresh review, hook, permission rule).

## Acceptance criteria
- [ ] Table in both tracks.
- [ ] Each row links to the exercise that provides the guard.

> _Feature names and flags here move between Claude Code releases — verify against current docs before editing the handouts (see the version-pinning issue)._

_Raised from a course review of current agentic-coding practice._
