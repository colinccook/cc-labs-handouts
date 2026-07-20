`Greenfield track · Exercise 5 of 8` — [Welcome](./README.md)

# Exercise 5 — Run two Claudes at once (greenfield)

**Track:** Greenfield · **Time:** ~30 min
**Builds on:** the MVP slices listed in `docs/brief.md`. · **Adds to your build:** two slices built in parallel, cleanly merged.

> **Why it matters:** git worktrees let you check out multiple branches into separate folders at once, sharing one repo. Run a Claude in each and you build two parts of your MVP simultaneously, with no context cross-contamination.

---

## Why this exercise

You'll pick two **independent** slices from your brief, set up a worktree for one, run a second Claude there, and build both in parallel — then merge. On a young codebase, be a little careful: early slices often share the same files, and parallelism only helps when they don't.

## Before you start

- Your brief with at least two remaining slices that genuinely don't depend on each other.
- A running skeleton (Exercise 0) so a second dev server can come up on its own port.

## Steps

**1. Find two independent slices and set up the worktree.** Paste this to pick two non-overlapping MVP slices from your brief and have Claude create a worktree + branch for one, with helper scripts:

```text
Look at docs/brief.md and find two remaining MVP slices that don't depend on each other. I want to build them in parallel with two Claude sessions via git worktrees: create a worktree + branch for one of them (git worktree add ../<repo>-<branch> -b <branch>), and remind me each worktree needs its own deps (node_modules / venv), its own .env, and a distinct dev-server port. Give me small scripts/wt-new.sh and scripts/wt-clean.sh to standardise it.

Then I'll open the worktree in a second terminal, run claude, and build both slices in parallel before merging.
```

**2. Open a second Claude in the worktree.** Open the new worktree folder in a second terminal and run `claude` there.

**3. Build both in parallel, then merge.** Let both sessions build their slice at once, then merge the branches back.

## What good looks like

- **Two independent slices** identified from your brief.
- **A second worktree** on its own branch with its own deps and port.
- **Both slices built and merged** — your MVP jumped forward on two fronts at once.

## Tips & watch-outs

- **Pick truly independent slices** — on a new codebase this is the hard part; if they share files, don't parallelise them.
- **Each worktree needs its own deps and a distinct port** — two skeletons on `:3000` collide.
- **Merge early** to avoid drift between the two young branches.

## 🎁 Bonus — go further

- **Teach Claude the convention** in `CLAUDE.md` so it can manage worktrees on request.
- **Pod it:** split three independent slices across three worktrees — a great thing to demo.
- **Automate cleanup** with `wt-clean.sh` + `git worktree prune`.

---

← Previous: [Exercise 4 — Hooks](./4-hooks-greenfield.md)  ·  Next: [Exercise 6 — Subagents (optional) →](./6-subagents-greenfield.md)
