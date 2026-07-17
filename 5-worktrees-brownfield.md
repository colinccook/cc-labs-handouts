`Brownfield track · Exercise 5 of 8` — [Overview & index](./README.md)

# Exercise 5 — Run two Claudes at once (brownfield)

**Track:** Brownfield · **Time:** ~30 min
**Builds on:** the independent second task you spec'd in Exercise 1's bonus. · **Adds to your build:** two features progressed in parallel, cleanly merged.

> **Why it matters:** git worktrees let you check out multiple branches into separate folders *at the same time*, sharing one repo. Run a Claude in each and you've got parallel agents that never step on each other's context — the "one dev, several streams of work" story made real.

---

## Why this exercise

You'll set up a worktree for a **second, independent** task, open a second Claude in it, and have both work in parallel — then bring them together. The key word is *independent*: parallelism only helps when the two pieces don't touch the same code.

## Before you start

- Two genuinely independent tasks (the second one from Exercise 1's bonus is ideal).
- Comfort creating a branch.

## Steps

**1. Set up the worktree.** Paste this to have Claude create a worktree + branch for your second, independent task, with helper scripts:

```text
I want to run two Claude sessions in parallel on independent work without them stepping on each other. Set up git worktrees for it: create a worktree + branch for a second, independent task I brought (git worktree add ../<repo>-<branch> -b <branch>), and remind me each worktree needs its own deps (node_modules / venv) and its own .env / port. Give me a small scripts/wt-new.sh and scripts/wt-clean.sh to standardise it.

Then I'll open the worktree in a second terminal, run claude there, and have both work in parallel before merging.
```

**2. Open a second Claude in the worktree.** Open the new worktree folder in a second terminal/window and run `claude` there.

**3. Work in parallel, then merge.** Let both sessions make progress at once, then bring the branches together when done.

## What good looks like

- **A second worktree** on its own branch, with its own deps installed.
- **Two Claude sessions** making progress at once, each with clean, separate context.
- **Both branches merged back** without treading on each other.

## Tips & watch-outs

- **Each worktree needs its own `node_modules`/venv and `.env`** — the #1 surprise. That's why the setup script installs deps.
- **Watch ports** — two dev servers on `:3000` collide. Assign per-worktree ports.
- **Only parallelise genuinely independent work** — coupled changes just create merge pain.

## 🎁 Bonus — go further

- **Teach Claude the convention.** Document worktrees in `CLAUDE.md` so Claude can spin one up / tear it down on request.
- **Three-way it.** If you're in a pod, split one member's task three ways across worktrees — a natural piece to demo.
- **Automate cleanup** with the `wt-clean.sh` script and `git worktree prune`.

---

← Previous: [Exercise 4 — Hooks](./4-hooks-brownfield.md)  ·  Next: [Exercise 6 — Subagents (optional) →](./6-subagents-brownfield.md)
