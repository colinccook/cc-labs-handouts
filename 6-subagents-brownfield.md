`Brownfield track · Exercise 6 of 8 · optional` — [Overview & index](./README.md)

# Exercise 6 — Build a specialist subagent (brownfield)

**Track:** Brownfield · *Optional* · **Time:** ~30 min
**Builds on:** the conventions and ADRs from Exercise 0. · **Adds to your build:** a reusable reviewer/test subagent tuned to your repo.

> **Why it matters:** a subagent runs with its own focused context and a narrow job. That's how you isolate a task, parallelise, or enforce a single review lens without cluttering your main session. Reach for one when you want *the same specialist judgement, repeatably*.

---

## Why this exercise

You'll build a subagent for a job you want done the same way every time — a **code-reviewer** that knows your conventions and ADRs, or a **test-writer** that follows your RED-GREEN loop. Then run it against a recent change and feel the difference focused context makes.

## Before you start

- `.claude/rules/` and `docs/adr/` from Exercise 0 (your subagent's standards come from these).
- A recent change to point it at.

## What you'll do

1. Have Claude create a subagent in `.claude/agents/` with a tight system prompt and a minimal toolset.
2. Run it against a recent diff.
3. Compare its focused output to just asking your main session.

## The prompt

Copy this into Claude as-is:

```text
Create a specialised subagent in .claude/agents/ for a review lens I care about in this repo — e.g. a code-reviewer that knows my conventions and ADRs, or a test-writer. Give it a tight system prompt (what to check, what to ignore, my standards from .claude/rules/) and the minimal toolset it needs. Then run it against a recent change and show me how its focused context beats asking the main session.
```

## What good looks like

- **A subagent file in `.claude/agents/`** with a sharp, single-purpose system prompt.
- **A real review (or test set)** produced against your recent change.
- A clear sense of *when* you'd reach for it versus the main session.

## Tips & watch-outs

- **Keep the toolset minimal** — a reviewer rarely needs write access.
- **Sharp system prompt = sharp output.** Tell it what to ignore as well as what to check.
- **Subagents shine for** isolating context, parallelising, and enforcing one lens.

## 🎁 Bonus — go further

- **Build a second lens.** A security-focused reviewer alongside the correctness one.
- **Chain it after a feature** — spec → build test-first → subagent review, as a mini pipeline.
- **Share it** with your team as a repo convention.

---

← Previous: [Exercise 5 — Worktrees](./5-worktrees-brownfield.md)  ·  Next: [Exercise 7 — MCP (optional) →](./7-mcp-brownfield.md)
