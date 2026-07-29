`Brownfield track · Exercise 6 of 7` — [Welcome](../README.md)

# Exercise 6 — Capture your reviewer as an agent (brownfield)

**Track:** Brownfield · **Time:** ~30 min
**Builds on:** the fresh-context review you ran by hand in Exercise 5. · **Adds to your build:** a reusable, read-only reviewer subagent — and the pattern for building agents for any repeatable job.

> **Why it matters:** doing the fresh-context review by hand means `/clear`-ing every time — and losing the session you were working in. A **subagent** runs in its *own* isolated context, so it gives you the same fresh-context review *on demand*, without ending your session: it gathers the diff and spec itself, and hands back findings to act on. Same beat as the `/specify` skill in Exercise 3 — do it by hand, then capture it — except a review needs *isolation*, which is exactly what an agent gives you and a skill (running in your current session) can't.

---

## Why this exercise

You'll turn the by-hand review into a `.claude/agents/reviewer.md` — cheap (Haiku), read-only, diff-scoped — and run it against a change. That teaches the pattern for agents in general: any time you want the *same specialist judgement, repeatably, in its own clean context*, you reach for one.

## Before you start

- Exercise 5 done — you've reviewed by hand and know what a good review looks like.
- A committed change and its spec to point the agent at.

## Steps

**1. Capture the review as an agent.** Paste this to build a cheap, read-only reviewer that carries its own fresh context:

```text
Create a subagent at .claude/agents/reviewer.md that reviews my current change against its spec, without fixing. Frontmatter: name: reviewer; a description listing trigger phrases ("review the diff", "review against the spec"); model: haiku (keep it cheap); and tools: Read, Bash, Glob, Grep (no Write or Edit — it must review, not change code). Body — the steps to run: (1) run git diff to see my current changes; (2) read the relevant specs/<feature>.md and my CLAUDE.md / .claude/rules for conventions; (3) map every acceptance criterion to the diff; (4) report unmet criteria, correctness risks with evidence, and any out-of-scope changes; (5) do NOT fix — report only, ending with a verdict: ship / needs-changes / discuss. Show me the file and stop.
```

**2. Run it, and keep working.** Invoke it explicitly with **`@reviewer`**, or just say *"use the reviewer subagent on my changes"*. Because of the `description` you gave it, Claude will also reach for it on its own when you ask to review a diff. Read its report. It ran in its own context on Haiku, read-only and diff-scoped, so it cost a fraction of a full review — and your main session is untouched.

**3. Close the loop with it.** Now a pass ends without `/clear`-ing anything: build test-first → **reviewer agent** → fix → commit → PR. Run a full pass this way on a second change and feel how much faster the review step gets. Then, when you move on to a genuinely new task, **`/clear`** — the agent keeps its own context, but your main session still works best starting fresh between tasks.

## What good looks like

- **`.claude/agents/reviewer.md`** — read-only (no Write/Edit), Haiku, single-purpose.
- **A review produced in its own context**, with your main session untouched.
- A clear sense of *when* you'd reach for an agent versus asking the main session.

## Tips & watch-outs

> **💰 Token-smart:** the reviewer runs on Haiku, diff-scoped and read-only — a few hundred tokens — and hands back a summary, not a whole transcript, so your session stays lean.

- **Agent or skill?** A *skill* is a set of steps you invoke in your current session (like `/specify`). An *agent* is a whole task you **hand off** — it runs in its own isolated context with its own model and toolset, so reach for one when you want to delegate a self-contained job, run several in parallel, or enforce a specific lens (like this read-only reviewer).
- **Read-only, always.** Leaving Write/Edit out of `tools:` is what stops it "helpfully" rewriting your code mid-review. (`Bash` is there for `git diff`.)
- **Sharp system prompt = sharp output.** Tell it what to *ignore* as well as what to check.
- **Report gaps, not style** — same discipline as the by-hand review.
- **Keep the toolset minimal** — a reviewer rarely needs more than read + git.

## 🎁 Bonus — go further

- **Compare with the built-in.** `/code-review low` is the bundled reviewer — no agent to build. Rule of thumb: the built-in for a quick pass, *your* agent when you want it spec-aware and tuned to your conventions.
- **Build a second agent — the pattern is the point.** Capture any repeatable specialist job as its own `.claude/agents/*.md`: a migration-checker, a docs-updater, a changelog-writer. Try one for your workflow.
- **Right-size the model.** We used Haiku to keep the review cheap and fast. For a particularly complex or high-stakes change where you want more confidence, make a second reviewer variant on a stronger model (e.g. Sonnet) at higher effort — keep the cheap one as your default and reach for the strong one only when the risk warrants it.
- **Restored the provided `code-reviewer`?** If you were working with our provided cc-labs-exercise repo and deleted it before Exercise 5, bring it back now and run it alongside yours on the same change. Notice what it misses: it's not prompted to check agaist a spec, but you may find some of the review guidance it defines helpful and want to use it in your own flows.

---

← Previous: [Exercise 5 — Review](./5-review-brownfield.md)  ·  Next: [Exercise 7 — Make it yours →](./7-loop-brownfield.md)
