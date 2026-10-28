`Greenfield track · Exercise 5 of 8` — [Welcome](../README.md)

# Exercise 5 — Review the diff in a fresh context (greenfield)

**Track:** Greenfield · **Time:** ~25 min
**Builds on:** the spec from Exercise 2 and the tested feature from Exercise 4. · **Adds to your build:** a reviewed, committed change — and the fresh-context review habit.

> **Why it matters:** when Copilot builds in minutes, *review* becomes the bottleneck — as AI velocity rises, changes get bigger and AI-authored code carries more defects per change. And the worst judge of the code is the very session that just wrote it: it still carries the whole build conversation, so it's anchored on its own reasoning and tends to defend it. The fix is to review with a **fresh context** that sees only the diff and your spec — not the conversation that produced it. *(It's the same reason Copilot CLI's built-in `code-review` agent runs in its own context window instead of inside your conversation.)*

---

## Why this exercise

You'll close a loop pass properly for the first time — reviewing the change **by hand**, and feeling why *where* you review matters. Review it in the same session that built it (biased — the build transcript is still loaded), then `/clear` and review again (honest — nothing but the diff and the spec). Fix what's real, then commit and open a PR. Next exercise you'll capture this into a one-command agent — but first, feel it.

## Before you start

- The feature from Exercise 4 in your working tree (uncommitted is fine — you'll review it *before* committing).
- Its spec (`specs/<feature>.md`) with acceptance criteria, plus your `docs/brief.md`.

## Steps

**1. Review it in the same session — and watch it defend itself.** As soon as the build is done, in the *same* session (which still has the whole build conversation loaded), ask it to review its own work:

```text
Review your change against specs/<feature>.md's acceptance criteria yourself, in this
conversation — don't hand it to a subagent. What doesn't meet them, and what are the risks?
```

Notice the tone: it tends to justify the choices it just made. That anchoring bias is the stale context talking — it can't see its own work fresh. (The "don't hand it to a subagent" line matters: Copilot will happily delegate a review to its built-in `code-review` agent, which would quietly give you a fresh context and spoil the comparison.)

**2. Now `/clear` and review again — fresh.** Clearing drops that build transcript, so the review starts from nothing but the diff and the spec. Paste:

```text
Review my current changes against specs/<feature>.md's acceptance criteria (and
docs/brief.md for the product intent) yourself — don't delegate to a subagent. Run
git diff to see them, and map each acceptance criterion to the change. Report: unmet
criteria, correctness risks (with evidence), and anything changed outside the task's
scope. Don't fix and don't nitpick style — just report, then give a verdict:
ship / needs-changes / discuss.
```

Same code, sharper read — the fresh context is the whole point.

**3. Fix what it flags.** Apply the real gaps and risks — ignore style noise — and re-run the fresh review if the change was substantial. The review only counts if it changes what you ship.

**4. Close the loop — commit and open a PR.** Now that it's reviewed and fixed, make it a clean, single-purpose commit and open a PR for the next reviewer — a teammate, or Copilot itself. Copilot CLI has the GitHub MCP server built in, so it can push and open the PR without any extra setup:

```text
Commit these reviewed changes with a clear, focused message (what changed and why; keep
the diff to this one change). Then push and open a PR summarising the change, how to test
it, and any risks the review flagged.
```

That's the terminus of every pass: **spec → build → test → review → commit → PR** — then `/clear` and start the next one clean.

## What good looks like

- **A reviewed change, committed once, with a PR open.**
- You saw the *same* change reviewed two ways — biased in-session, honest after `/clear` — and felt the difference.
- The gaps it found were real (unmet criteria, actual risks), and you fixed them before the PR.

## Tips & watch-outs

> **💰 Token-smart:** `/clear` between tasks is a cost habit too — it sheds context you no longer need. And a small, focused diff is cheaper *and* sharper to review than a sprawling one, so commit often. Note too: letting Copilot run the commit/PR is convenient but spends tokens driving `git` and GitHub — once you're comfortable, `!git commit -m "…"` and `!gh pr create` (the `!` prefix skips the model entirely) or the `/pr create` command are quicker and cheaper.

- **Report gaps, not style.** A reviewer told to "find problems" over-reports and nudges you toward over-engineering. Keep it on unmet criteria + real risks.
- **Don't let AI-written tests be the only gate.** A model can write tests that match its own code rather than the spec — a fresh-context review is a second, differently-biased check.
- **Keep it anchored to the spec.** "Review against the acceptance criteria," not "does this look okay" — that's what makes the review objective.
- **`/clear` vs `/compact`.** `/compact` *summarises* the conversation to save space — the bias survives in the summary. For an honest review you want `/clear`.

## 🎁 Bonus — go further

- **Compare with the built-in.** Run **`/review`** — Copilot CLI's bundled `code-review` agent, zero setup. It runs in its own context, is tuned for high signal-to-noise, and never modifies code. You can narrow it with a prompt (`/review only the changes under src/`). See how its findings compare to your by-hand pass — notably, it doesn't know your spec.
- **Add the security lens.** Run the built-in **`/security-review`** on the change — a focused pass for high-confidence vulnerabilities in your local changes. That's your dedicated security check, which is exactly why the review prompt above stays on *correctness* and leaves security to this.
- **A third reviewer on GitHub.** On the PR you just opened, request **Copilot** as a reviewer. Copilot code review reads the same `.github/copilot-instructions.md` and `.github/instructions/` files — another fresh, differently-placed pair of eyes.
- **Coming next:** you'll turn this exact review into a one-command reviewer **agent** (Exercise 6), so you get the fresh-context read *without* `/clear`-ing your session.

---

← Previous: [Exercise 4 — TDD](./4-tdd-greenfield.md)  ·  Next: [Exercise 6 — Agents →](./6-agents-greenfield.md)
