`Greenfield track · Exercise 4 of 7` — [Welcome](../README.md)

# Exercise 4 — Build it test-first (greenfield)

**Track:** Greenfield · **Time:** ~30 min
**Builds on:** the spec you drafted with `/specify` at the end of Exercise 3. · **Adds to your build:** your first test harness, and that slice built entirely RED → GREEN.

> **Why it matters:** left to its own devices, Claude tends to write the implementation first and then tests shaped to fit the code it just wrote — so a test you never saw fail might already pass, or pass for the wrong reason, proving nothing about the new behaviour. Forcing **RED → GREEN** — watch the test fail against the acceptance criteria *before* any implementation exists — is what proves the test can actually catch a broken implementation. Your project has had no tests until now, deliberately. This is where that changes.

---

## Why this exercise

Two steps: first stand up a test framework (your skeleton has none yet — that was on purpose, so this moment lands fresh), then build the slice you spec'd last exercise **test-first**, turning its acceptance criteria into failing tests before any implementation.

## Before you start

- The **spec you drafted at the end of Exercise 3** (`specs/<slice>.md`), with concrete acceptance criteria.
- Your stack from `docs/adr/0001-initial-stack.md` — it informs your test runner.

## Steps

**1. Stand up the test harness — your choice of runner.** Your skeleton has none yet, on purpose. Paste this so Claude proposes but *you* decide:

```text
My project has no test framework yet. Before setting anything up, ask me what I want: the test runner (recommend the idiomatic one for my stack from ADR-0001, but let me choose), and whether I care about unit vs integration and frontend vs backend tests for this project. Then set up my chosen runner, add the command to CLAUDE.md, and write one trivial passing test to prove it runs. Keep it minimal.
```

**2. Add the RED-GREEN rule.** Paste this on its own — it makes test-first-against-the-spec the default, enforced way to build:

```text
Add an always-on rule to .claude/rules/testing.md titled "Building from a spec — RED-GREEN (YOU MUST)": when implementing a feature that has a spec in specs/, work test-first against its acceptance criteria — (1) take the next acceptance criterion and write a test that captures it, no implementation yet; (2) run it and SHOW me it fails for the right reason — the behaviour is missing, not a typo (RED); (3) write the minimum code to pass, then run that test and the full suite (GREEN, no regressions); (4) refactor if useful, keeping green, then move to the next criterion. NEVER modify a test just to make it pass — if a criterion is ambiguous or a test looks wrong, STOP and ask me. Show me the rule file and stop.
```

**3. Commit before you implement.** Commit the harness and the rule file now, so the diff you review in Exercise 5 is just the slice you're about to build, nothing else mixed in.

**4. `/clear`, then hand Claude just the spec.** Clear so what happens next is the rule doing the work, not memory of the conversation that just wrote it:

```text
/clear
```

```text
Implement specs/<slice>.md.
```

That's the whole prompt. You already made test-first-against-the-spec a `YOU MUST` rule in step 2 — restating RED-GREEN here would just be asking Claude to do what it's already required to do. If you want to confirm the rule is actually driving it, ask Claude which rule it's following before it starts.

**5. Watch the RED before the GREEN.** The tests must fail for the right reason before any implementation. If Claude jumps straight to green, make it back up.

## What good looks like

- **A test runner set up** for your stack, with its command in `CLAUDE.md`.
- **`.claude/rules/testing.md`** with the RED-GREEN-against-acceptance-criteria rule.
- **A slice built test-first** — you saw the tests fail, mapped to acceptance criteria, then pass, then the whole suite green.

## Tips & watch-outs

> **💰 Token-smart:** a runnable test is an objective "done" signal — it ends the guess → run → correct churn that quietly burns tokens when Claude has no way to check itself.

- **Standing up the harness takes time** — budget for it; that's expected on a fresh project.
- **The classic cheat is weakening the test to pass** — the "never modify the test" line in your rule prevents it.
- **"Show me the RED"** is the discipline. If Claude jumps to green, make it back up.

## 🎁 Bonus — go further

- **Add a coverage command** to `CLAUDE.md` so you can see what's protected as the MVP grows.

---

← Previous: [Exercise 3 — Skills](./3-skills-greenfield.md)  ·  Next: [Exercise 5 — Review →](./5-review-greenfield.md)
