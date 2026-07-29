`Brownfield track · Exercise 4 of 7` — [Welcome](../README.md)

# Exercise 4 — Build it test-first (brownfield)

**Track:** Brownfield · **Time:** ~20–25 min
**Builds on:** the spec you drafted with `/specify` at the end of Exercise 3. · **Adds to your build:** a RED-GREEN rule tied to your acceptance criteria, and that task implemented test-first.

> **Why it matters:** left to its own devices, Claude tends to write the implementation first and then tests shaped to fit the code it just wrote — so a test you never saw fail might already pass, or pass for the wrong reason, proving nothing about the new behaviour. Forcing **RED → GREEN** — watch the test fail against the acceptance criteria *before* any implementation exists — is what proves the test can actually catch a broken implementation instead of rubber-stamping whatever code happens to be there. It also gives the agent an objective "am I done" signal.

---

## Why this exercise

You'll add a rule that makes Claude build **test-first against a spec's acceptance criteria**, then use it to implement the task you spec'd last exercise: a failing test that proves it fails for the right reason, *then* the minimum code to pass. This is how the spec you wrote becomes executable, not just prose.

## Before you start

- The **spec you drafted at the end of Exercise 3** (`specs/<feature>.md`), with concrete acceptance criteria.
- A working test command. **No test runner yet?** That's Step 0 below — budget extra time for it.

## Steps

**0. No test command yet? Stand it up first.** Skip straight to step 1 if your repo already has a working test runner.

```text
This project has no test runner set up yet. Before setting anything up, ask me what I want:
the test runner (recommend the idiomatic one for this stack, but let me choose), and whether
I care about unit vs integration and frontend vs backend tests. Then set up my chosen runner,
add the command to CLAUDE.md, and write one trivial passing test to prove it runs. Keep it
minimal.
```

**1. Add the RED-GREEN rule to your context.** Paste this — it makes test-first-against-the-spec the default, enforced way to build:

```text
Add an always-on rule to .claude/rules/testing.md titled "Building from a spec — RED-GREEN
(YOU MUST)": when implementing a feature that has a spec in specs/, work test-first
against its acceptance criteria — (1) take the next acceptance criterion and write a test
that captures it, no implementation yet; (2) run it and SHOW me it fails for the right
reason — the behaviour is missing, not a typo (RED); (3) write the minimum code to pass,
then run that test and the full suite (GREEN, no regressions); (4) refactor if useful,
keeping green, then move to the next criterion. NEVER modify a test just to make it pass —
if a criterion is ambiguous or a test looks wrong, STOP and ask me. Show me the rule file
and stop.
```

**2. Commit before you implement.** You're about to build a real change — commit the rule file (and anything else pending) now (ask Claude to commit, or run `git commit` yourself), so the diff you review in Exercise 5 is just this change, nothing else mixed in.

**3. `/clear`, then hand Claude just the spec.** Clear so what happens next is the rule doing the work, not memory of the conversation that just wrote it:

```text
/clear
```

```text
Implement specs/<your-feature>.md.
```

That's the whole prompt. You already made test-first-against-the-spec a `YOU MUST` rule in step 1 — restating RED-GREEN here would just be asking Claude to do what it's already required to do. If you want to confirm the rule is actually driving it, ask Claude which rule it's following before it starts.

**4. Watch the RED before the GREEN.** The bit that makes it real is seeing the test fail for the right reason *before* any implementation. If Claude jumps straight to green, make it back up.

## What good looks like

- **`.claude/rules/testing.md`** with the RED-GREEN-against-acceptance-criteria rule, always on.
- **A test you saw fail first**, mapped to an acceptance criterion — then pass. Not one written alongside the code.
- **The full suite green**, so you know the change didn't regress anything.

## Tips & watch-outs

> **💰 Token-smart:** a runnable test is an objective "done" signal — it ends the guess → run → correct churn that quietly burns tokens when Claude has no way to check itself.

- **No test runner yet? Standing it up takes real time** — budget for it; that's expected on a repo that's never had tests.
- **The classic cheat is Claude weakening the test to pass.** The "never modify the test" line in your rule is what prevents it — call it out if you see it happen.
- **"Show me the RED"** is the whole discipline. If it jumps to green, make it back up.
- **Anchor to the criteria, not vibes.** One test per acceptance criterion keeps "done" objective and traceable back to the spec.

## 🎁 Bonus — go further

- **Backfill a test for a past bug.** Reproduce it as a failing test first, then confirm the fix keeps it green — that bug can never silently return.
- **Machine-check "done."** Imagine a hook that runs this suite automatically so green isn't a matter of trust — the kind of automation you can layer on once the loop is solid.

---

← Previous: [Exercise 3 — Skills](./3-skills-brownfield.md)  ·  Next: [Exercise 5 — Review →](./5-review-brownfield.md)
