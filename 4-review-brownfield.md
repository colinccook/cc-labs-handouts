`Brownfield track · Exercise 4 of 8` — [Welcome](./README.md)

# Exercise 4 — Review the diff in a fresh context (brownfield)

**Track:** Brownfield · **Time:** ~30 min
**Builds on:** the spec from Exercise 1 and the tested change from Exercise 3. · **Adds to your build:** a reusable, read-only reviewer subagent tuned to your repo.

> **Why it matters:** when Claude builds in minutes, *review* becomes the bottleneck — as AI velocity rises, review time and PR size balloon and AI-authored code carries more defects per change. And the worst judge of the code is the model that just wrote it: it's anchored on its own reasoning and tends to defend it. The fix is a reviewer with a **fresh context** that sees only the diff and your spec — not the conversation that produced it. *(Anthropic's own guidance: "a fresh context improves code review since Claude won't be biased toward code it just wrote.")*

---

## Why this exercise

You'll feel the problem by hand first — review with the build transcript still loaded (biased), then `/clear` and review again (honest) — and then **capture that as a reusable reviewer subagent** so you get the fresh-context review on demand *without* throwing away your working session. The reviewer checks the diff against your spec's acceptance criteria and reports gaps. It does **not** fix.

## Before you start

- A **committed** change to review — the feature from Exercise 1 or the test-first unit from Exercise 3. Commit it first; you need a clean diff.
- Its spec (`specs/<feature>.md`) with acceptance criteria.

## Steps

**1. Commit, so there's a diff to review.** Small, single-purpose commits are what make review tractable *and* cheap. If you've been committing as you go, you already have one.

**2. Review it in the same session — and watch it defend itself.** Without clearing anything, ask the session that just built the code to review its own work:

```text
Review your change against specs/<feature>.md's acceptance criteria. What doesn't meet them, and what are the risks?
```

Notice the tone: it tends to justify the choices it just made. That's the anchoring bias — it can't see its own work fresh.

**3. Now `/clear` and review again — fresh.** Clear the context, then paste:

```text
Review the diff on this branch against specs/<feature>.md's acceptance criteria. Run git diff to see the change, and map each acceptance criterion to it. Report: unmet criteria, correctness/security risks (with evidence), and anything changed outside the task's scope. Don't fix and don't nitpick style — just report, then give a verdict: ship / needs-changes / discuss.
```

Same code, sharper read — the fresh context is the whole point. Clearing between tasks is a good habit in its own right: it sheds context you no longer need, which keeps you fast and your token use down. The one catch is doing it *mid-build* — you lose the working session you were in.

**4. Capture it as a reviewer agent.** A subagent runs in its *own* isolated context — so it gives you that same fresh-context review *as a step inside your flow*, without clearing your main session: it gathers the diff and spec itself, and its findings come straight back for you to act on. Paste this to build a cheap, read-only one:

```text
Create a subagent at .claude/agents/reviewer.md that reviews my current change against its spec, without fixing. Frontmatter: name: reviewer; a description listing trigger phrases ("review the diff", "review against the spec"); model: haiku (keep it cheap); and tools: Read, Bash, Glob, Grep (no Write or Edit — it must review, not change code). Body — the steps to run: (1) run git diff against the base branch; (2) read the relevant specs/<feature>.md and my CLAUDE.md / .claude/rules for conventions; (3) map every acceptance criterion to the diff; (4) report unmet criteria, correctness/security risks with evidence, and any out-of-scope changes; (5) do NOT fix — report only, ending with a verdict: ship / needs-changes / discuss. Show me the file and stop.
```

**5. Run it, and keep working.** Trigger the reviewer — by name, or just *"review this diff against the spec."* Read its report. It ran in its own context on Haiku, read-only and diff-scoped, so it cost a fraction of a full review — and your main session is untouched.

## What good looks like

- **A committed diff** and the spec to check it against.
- **`.claude/agents/reviewer.md`** — read-only (no Write/Edit), Haiku, single-purpose.
- **A review that maps to your acceptance criteria** and names real gaps and risks — not style nits — with a verdict.
- The realisation: **fresh context = honest review** — `/clear` gives it to you by hand, and the agent gives it on demand with findings in hand, without ending your working session.

## Tips & watch-outs

> **💰 Token-smart:** the reviewer runs on Haiku, diff-scoped and read-only — a few hundred tokens — and hands back a summary instead of dumping a whole review transcript into your session. `/clear` between tasks is the same instinct: shed context you no longer need.

- **Report gaps, not style.** A reviewer told to "find problems" over-reports and nudges you toward over-engineering. Scope it to unmet criteria + real risks.
- **Don't let AI-written tests be the only gate.** A model can write tests that match its own code rather than the spec — the independent reviewer is a second, differently-biased check (that's why TDD *and* review both earn their place).
- **Read-only, always.** Leaving Write/Edit out of `tools:` is what stops it "helpfully" rewriting your code mid-review. (`Bash` is there for `git diff`.)
- **Cheap by design.** Haiku + diff-scoped + read-only ≈ a few hundred tokens — the opposite of firing off a big multi-agent review.
- **The heavy end exists, but not for here:** `pr-review-toolkit` (6 agents in parallel) and the cloud PR-review service are powerful but overkill and costly for a live room.

## 🎁 Bonus — go further

- **Compare with the built-in.** Run `/code-review low` — Claude's bundled reviewer, zero setup; low effort keeps it fast and high-confidence. Compare its findings to your agent's. Rule of thumb: the built-in for a quick pass, *your* agent when you want it spec-aware and tuned to your conventions.
- **Add the security lens for free.** Run the built-in `/security-review` on the same change — a ready-made security pass that complements your correctness reviewer, nothing to build.
- **Wire it into "done."** Foreshadowing Exercise 5: a `Stop` hook that reminds you to run the reviewer before a task is called finished, or have your main session auto-delegate to it.
- **Run the whole loop end to end.** On a second task: spec (1) → build test-first (3) → **commit** → reviewer agent (4) → fix what it flags → **commit again**. That commit → review → fix → commit rhythm *is* the loop — feel how much faster the second pass goes.

---

← Previous: [Exercise 3 — TDD](./3-tdd-brownfield.md)  ·  Next: [Exercise 5 — Hooks →](./5-hooks-brownfield.md)
