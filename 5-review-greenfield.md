`Greenfield track · Exercise 5 of 7` — [Welcome](./README.md)

# Exercise 5 — Review the diff in a fresh context (greenfield)

**Track:** Greenfield · **Time:** ~25 min
**Builds on:** the spec from Exercise 2 and the tested feature from Exercise 4. · **Adds to your build:** a reviewed, committed change — and the fresh-context review habit.

> **Why it matters:** when Claude builds in minutes, *review* becomes the bottleneck — as AI velocity rises, review time and change size balloon and AI-authored code carries more defects per change. And the worst judge of the code is the model that just wrote it: it's anchored on its own reasoning and tends to defend it. The fix is to review with a **fresh context** that sees only the diff and your spec — not the conversation that produced it. *(Anthropic's own guidance: "a fresh context improves code review since Claude won't be biased toward code it just wrote.")*

---

## Why this exercise

You'll close a loop pass properly for the first time — reviewing the change **by hand**, and feeling why *where* you review matters. Review it in the same session that built it (biased), then `/clear` and review again (honest). Fix what's real, then commit and open a PR. Next exercise you'll capture this into a one-command agent — but first, feel it.

## Before you start

- A **committed** feature built on your skeleton — the one from Exercise 2, hardened test-first in Exercise 4. Commit it first; you need a clean diff.
- Its spec (`specs/<feature>.md`) with acceptance criteria, plus your `docs/brief.md`.

## Steps

**1. Commit, so there's a diff to review.** Small, single-purpose commits are what make review tractable *and* cheap. If you've been committing as you go, you already have one.

**2. Review it in the same session — and watch it defend itself.** Without clearing anything, ask the session that just built the feature to review its own work:

```text
Review your change against specs/<feature>.md's acceptance criteria. What doesn't meet them, and what are the risks?
```

Notice the tone: it tends to justify the choices it just made. That's the anchoring bias — it can't see its own work fresh.

**3. Now `/clear` and review again — fresh.** Clear the context, then paste:

```text
Review the diff on this branch against specs/<feature>.md's acceptance criteria (and docs/brief.md for the product intent). Run git diff to see the change, and map each acceptance criterion to it. Report: unmet criteria, correctness/security risks (with evidence), and anything changed outside the task's scope. Don't fix and don't nitpick style — just report, then give a verdict: ship / needs-changes / discuss.
```

Same code, sharper read — the fresh context is the whole point.

**4. Fix what it flags.** Apply the real gaps and risks it found — ignore style noise — and re-run the fresh review if the change was substantial. The review only counts if it changes what you ship.

**5. Close the loop — commit, push, open a PR.** A pass isn't done until the reviewed change is a clean, single-purpose commit with a PR open for the next reviewer — a teammate, or Claude itself.

```text
Commit this reviewed change with a clear, focused message (what changed and why; keep the diff to this one change). Then push and open a PR summarising the change, how to test it, and any risks the review flagged.
```

That's the terminus of every pass: **spec → build → test → review → commit → PR** — then `/clear` and start the next one clean. *(The `commit-commands` plugin from Exercise 3 or `gh pr create` writes the PR; you can hook Claude up to review PRs on GitHub too — `/install-github-app`.)*

## What good looks like

- **A committed, reviewed diff with a PR open.**
- You saw the *same* change reviewed two ways — biased in-session, honest after `/clear` — and felt the difference.
- The gaps it found were real (unmet criteria, actual risks), and you fixed them before the PR.

## Tips & watch-outs

> **💰 Token-smart:** `/clear` between tasks is a cost habit too — it sheds context you no longer need. And a small, focused diff is cheaper *and* sharper to review than a sprawling one, so commit often.

- **Report gaps, not style.** A reviewer told to "find problems" over-reports and nudges you toward over-engineering. Keep it on unmet criteria + real risks.
- **Don't let AI-written tests be the only gate.** A model can write tests that match its own code rather than the spec — a fresh-context review is a second, differently-biased check.
- **Keep it anchored to the spec.** "Review against the acceptance criteria," not "does this look okay" — that's what makes the review objective.

## 🎁 Bonus — go further

- **Compare with the built-in.** Run `/code-review low` — Claude's bundled reviewer, zero setup; low effort keeps it fast and high-confidence. See how its findings compare to your by-hand pass.
- **Add the security lens for free.** Run the built-in `/security-review` on the same change — a ready-made security pass, nothing to build.
- **Coming next:** you'll turn this exact review into a one-command reviewer **agent** (Exercise 6), so you get the fresh-context read *without* `/clear`-ing your session.

---

← Previous: [Exercise 4 — TDD](./4-tdd-greenfield.md)  ·  Next: [Exercise 6 — Agents →](./6-agents-greenfield.md)
