`Greenfield track · Exercise 6 of 8 · optional` — [Overview & index](./README.md)

# Exercise 6 — Build a specialist subagent (greenfield)

**Track:** Greenfield · *Optional* · **Time:** ~30 min
**Builds on:** the conventions and ADR from Exercise 0. · **Adds to your build:** a consistency-enforcing reviewer for your young codebase.

> **Why it matters:** a subagent runs with its own focused context and a narrow job. On a new project the highest-value one is a **consistency enforcer** — it stops drift while your conventions are still forming, before bad patterns calcify.

---

## Why this exercise

You'll turn the conventions and decisions you set on day one into a subagent that checks new code against them — a reviewer with a checklist built from `.claude/rules/conventions.md` and your ADR, or a test-writer that follows your RED-GREEN loop. Then run it on your latest feature.

## Before you start

- `.claude/rules/conventions.md` and `docs/adr/` from Exercise 0.
- A recent feature to review.

## Steps

**1. Create the subagent and run it.** Paste this to have Claude build a subagent in `.claude/agents/` that encodes your conventions, then run it against your last feature:

```text
Create a specialised subagent in .claude/agents/ that enforces the conventions I've established for this new project — read .claude/rules/conventions.md and docs/adr/ and turn them into a code-reviewer's checklist, or a test-writer that follows my Exercise-3 testing loop. Give it a tight system prompt and the minimal toolset. Then run it against my last feature and show me what it catches that keeps the young codebase consistent.
```

**2. See what it catches.** Look at what the subagent flags — the drift it catches now is what keeps the codebase consistent as the MVP grows.

## What good looks like

- **A subagent in `.claude/agents/`** that reviews against *your* stated conventions.
- **A real review** of your latest feature, catching drift early.
- Confidence that as the MVP grows, new code stays consistent.

## Tips & watch-outs

- **Consistency is the win here** — on a young codebase, catching drift now saves a painful cleanup later.
- **Keep the toolset minimal**; a reviewer rarely needs write access.
- **Sharp system prompt = sharp output.**

## 🎁 Bonus — go further

- **Add a test-writer subagent** that turns a spec's acceptance criteria into failing tests.
- **Chain it:** `/specify` → build test-first → subagent review.
- **Share it** as your project's review convention from the start.

---

← Previous: [Exercise 5 — Worktrees](./5-worktrees-greenfield.md)  ·  Next: [Exercise 7 — MCP (optional) →](./7-mcp-greenfield.md)
