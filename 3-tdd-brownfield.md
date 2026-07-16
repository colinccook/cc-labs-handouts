`Brownfield track · Exercise 3 of 8` — [Overview & index](./README.md)

# Exercise 3 — Build it test-first (brownfield)

**Track:** Brownfield · **Time:** ~30 min
**Builds on:** the testable acceptance criteria you wrote in Exercise 1. · **Adds to your build:** a RED-GREEN rule, and code change locked behind real tests.

> **Why it matters:** left alone, Claude writes the test and the implementation together — so the test can't actually catch a broken implementation. Forcing **RED → GREEN → REFACTOR** turns tests into a real safety net *and* gives the agent an objective "am I done" signal. Especially powerful on existing code you're scared to break.

---

## Why this exercise

You'll add a short TDD rule to your context, then drive one change **test-first**: a failing test that proves it fails for the right reason, *then* the minimum code to pass. For existing behaviour, you'll write a **characterization test** that locks in what the code does today before you touch it.

## Before you start

- A working test command (if you have none, that becomes step one — see the greenfield version's harness step for the pattern).
- One small, testable unit from your task — ideally with logic worth protecting.

## What you'll do

1. Add the RED-GREEN loop as an always-on rule.
2. Pick one unit. If you're changing existing behaviour, characterization-test it first.
3. Watch Claude show you the **RED** before it implements — that's the bit that makes it real.

## The prompt

> Add this loop to `.claude/rules/testing.md` (always-on): 1) write a failing test that captures the desired behaviour — no implementation yet; 2) run it and SHOW me it fails for the right reason (RED); 3) write the minimum code to pass; 4) run it and the full suite (GREEN); 5) refactor green. **IMPORTANT: never modify a test to make it pass — if the test is wrong, stop and tell me.**
>
> Now pick one small, testable unit in my task. If I'm changing existing behaviour, **first write a characterization test** that locks in what it does today, then extend test-first. Show me the RED before you implement.

## What good looks like

- **`.claude/rules/testing.md`** with the RED-GREEN loop, always on.
- **A test that you saw fail first**, then pass — not one written alongside the code.
- **The full suite green**, so you know the change didn't regress anything.

## Tips & watch-outs

- **The classic cheat is Claude weakening the test to pass.** The "never modify the test" line is what prevents it — call it out if you see it happen.
- **Characterization tests before refactor** are the brownfield superpower: lock current behaviour, *then* change with confidence.
- **"Show me the RED"** is the whole discipline. If it jumps to green, make it back up.

## 🎁 Bonus — go further

- **Backfill a test for a past bug.** Reproduce it as a failing test first, then confirm the fix keeps it green — that bug can never silently return.
- **Machine-check "done."** Foreshadowing Exercise 4: imagine a hook that runs this suite automatically so green isn't a matter of trust.
- **Raise coverage on a risky module** by characterization-testing it before your next change there.

## If you get stuck

No test framework yet? Ask Claude to set up the idiomatic runner for your stack first (that's legitimately part of this exercise) — then continue. On the sample app? Same exercise.

---

← Previous: [Exercise 2 — Skills](./2-skills-brownfield.md)  ·  Next: [Exercise 4 — Hooks →](./4-hooks-brownfield.md)
