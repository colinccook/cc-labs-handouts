`Greenfield track · Exercise 3 of 8` — [Overview & index](./README.md)

# Exercise 3 — Build it test-first (greenfield)

**Track:** Greenfield · **Time:** ~30 min
**Builds on:** the running feature from Exercise 1. · **Adds to your build:** your first test harness, and a feature built entirely RED → GREEN.

> **Why it matters:** left alone, Claude writes the test and the code together — so the test can't catch a broken implementation. Forcing **RED → GREEN → REFACTOR** turns tests into a real safety net and gives Claude an objective "am I done" signal. Your project has had no tests until now — deliberately. This is where that changes.

---

## Why this exercise

Two steps: first stand up a test framework (your skeleton has none yet — that was on purpose, so this moment lands fresh), then build your next MVP slice **test-first**, turning its acceptance criteria into failing tests before any implementation.

## Before you start

- Exercise 1 done (a working first feature) and, ideally, a spec for the *next* slice.
- Know your stack from `docs/adr/0001-initial-stack.md` — it picks your test runner.

## What you'll do

1. **Step 1** — have Claude set up the idiomatic test runner and prove it runs.
2. **Step 2** — add the RED-GREEN rule, then build the next slice test-first.
3. Watch the **RED** appear before any implementation.

## The prompts

**Step 1 — stand up the harness:**

Copy this into Claude as-is:

```text
My project has no test framework yet. Set up the idiomatic test runner for my stack (ADR-0001), add the command to CLAUDE.md, and write one trivial passing test to prove it runs. Keep it minimal.
```

**Step 2 — add the rule and build test-first:**

Copy this into Claude as-is:

```text
Add this loop to .claude/rules/testing.md (always-on): 1) write a failing test — no implementation yet; 2) run it and SHOW me it fails for the right reason (RED); 3) minimum code to pass; 4) run it + full suite (GREEN); 5) refactor green. IMPORTANT: never modify a test to make it pass — if the test is wrong, stop and tell me.

Now take the next slice from docs/brief.md, turn its spec's acceptance criteria into failing tests, and build it RED→GREEN. Show me the RED first.
```

## What good looks like

- **A test runner set up** for your stack, with its command in `CLAUDE.md`.
- **`.claude/rules/testing.md`** with the RED-GREEN loop.
- **A new feature built test-first** — you saw the tests fail, then pass, then the whole suite green.

## Tips & watch-outs

- **Standing up the harness takes time** — budget for it; that's expected on a fresh project.
- **The classic cheat is weakening the test to pass** — the "never modify the test" line prevents it.
- **"Show me the RED"** is the discipline. If Claude jumps to green, make it back up.

## 🎁 Bonus — go further

- **Retro-test Exercise 1's feature.** Write a characterization test that locks in what you built earlier, so future changes can't silently break it.
- **Machine-check "done"** — next exercise wires a hook to run this suite automatically.
- **Add a coverage command** to `CLAUDE.md` so you can see what's protected as the MVP grows.

---

← Previous: [Exercise 2 — Skills](./2-skills-greenfield.md)  ·  Next: [Exercise 4 — Hooks →](./4-hooks-greenfield.md)
