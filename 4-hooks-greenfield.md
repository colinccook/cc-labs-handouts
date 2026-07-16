`Greenfield track · Exercise 4 of 8` — [Overview & index](./README.md)

# Exercise 4 — Make your guardrails automatic (greenfield)

**Track:** Greenfield · **Time:** ~20–30 min
**Builds on:** the test harness from Exercise 3. · **Adds to your build:** a hook that keeps your young codebase formatted and green automatically.

> **Why it matters:** a `CLAUDE.md` rule is something the model *may* follow. A hook *always* runs — a deterministic shell command on a lifecycle event. On a fresh codebase this is how you keep consistency from slipping while everything is still forming.

---

## Why this exercise

You'll wire **one** real hook: auto-format the files Claude edits. If your scaffold didn't set up a formatter, this exercise sets one up (legitimately part of it). Optionally, a `Stop` hook that runs the suite you built last exercise.

> **⚠ Security:** hooks run arbitrary shell with *your* permissions. Only wire commands you trust.

## Before you start

- Exercise 3 done (you have a test command). A formatter for your stack — or let Claude pick and install the idiomatic one.

## What you'll do

1. Confirm the exact command in your terminal first.
2. Wire a `PostToolUse` format hook (installing the formatter if needed).
3. Optionally add a `Stop` hook running your tests.
4. Restart Claude, edit a file, watch it fire.

## The prompt

> Add a `PostToolUse` hook to `.claude/settings.json` that runs my formatter on files you edit. If my scaffold didn't set a formatter up, pick the idiomatic one for my stack (ADR-0001), install it, and record the choice. **First tell me the exact command to confirm in my terminal**, then wire it scoped to the right file types. Note that hooks run arbitrary shell with my permissions.
>
> Bonus: add a `Stop` hook that runs the test command from Exercise 3, so every stopping point is green.

## What good looks like

- **A formatter set up** for your stack (if it wasn't) and a hook that runs it automatically on edits.
- **(Optional) a `Stop` hook** running your suite — your prototype can't quietly drift to red.
- Consistent formatting from here on, without you ever asking.

## Tips & watch-outs

- **Setting up the formatter is fair game** here if your scaffold skipped it.
- **Test the command in a terminal first**; **restart** after wiring.
- **Keep it fast** — scope the test hook to changed files if needed.

## 🎁 Bonus — go further

- **Protect a path** with a `PreToolUse` hook (e.g. your `.env` or generated files).
- **Add a completion notification** so you know when a long build step finishes.
- **Explore `/hooks`** to see all lifecycle events.

## If you get stuck

Hook not firing? Restart, then check the matcher and that the command runs standalone. On the sample app? Use the brownfield version.

---

← Previous: [Exercise 3 — TDD](./3-tdd-greenfield.md)  ·  Next: [Exercise 5 — Worktrees →](./5-worktrees-greenfield.md)
