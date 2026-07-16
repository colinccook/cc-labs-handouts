`Brownfield track · Exercise 4 of 8` — [Overview & index](./README.md)

# Exercise 4 — Make your guardrails automatic (brownfield)

**Track:** Brownfield · **Time:** ~20–30 min
**Builds on:** the formatter/tests already in your repo, and the suite from Exercise 3. · **Adds to your build:** a hook that enforces quality without anyone remembering to.

> **Why it matters:** a `CLAUDE.md` rule is something the model *may* follow. A hook *always* runs — it's a deterministic shell command fired on a lifecycle event. That's how you make a quality gate non-negotiable instead of hopeful.

---

## Why this exercise

You'll wire **one** real hook into your repo: auto-format the files Claude edits, every time, with no reminder. Optionally, a second hook that runs your tests when Claude stops — so "done" is machine-checked, not vibes.

> **⚠ Security:** hooks run arbitrary shell with *your* permissions. Only wire commands you trust and understand — never paste a hook from a stranger.

## Before you start

- Your formatter command (prettier / ruff / gofmt / …) and your test command, both confirmed working in a plain terminal.

## What you'll do

1. Confirm the exact command in your terminal first (this prevents 90% of hook pain).
2. Wire a `PostToolUse` format hook.
3. Optionally add a `Stop` hook that runs your tests.
4. Restart Claude (hook changes need it), then edit a file and watch the hook fire.

## The prompt

> Add one `PostToolUse` hook to `.claude/settings.json` that runs my formatter on files you edit (e.g. prettier / ruff / gofmt). **First tell me the exact command to confirm in my terminal**, then wire it scoped to the file types it applies to. Explain that hooks run arbitrary shell with my permissions.
>
> Bonus: add a `Stop` hook that runs my test command (the one from Exercise 3) so "done" is machine-checked, not vibes.

## What good looks like

- **A format hook** that fires automatically after Claude edits a matching file — you never ask it to format again.
- **(Optional) a `Stop` hook** running your suite, so a session can't quietly end on red.
- The commands are scoped and fast enough not to drag every turn.

## Tips & watch-outs

- **Test the command in a plain terminal first** — a wrong command string is the #1 cause of hook pain.
- **Hook changes need a restart** to take effect.
- **Heavy hooks slow the loop** — scope the test hook to changed files if your suite is slow.
- **Re-read the security note** before wiring anything.

## 🎁 Bonus — go further

- **Protect a path.** Add a `PreToolUse` hook that blocks edits to a sensitive file/dir (secrets, generated code) — a guardrail Claude *can't* talk its way past.
- **Get notified.** Add a completion notification (desktop/Slack) so you know when a long run finishes.
- **Browse `/hooks`** to see every lifecycle event (PreToolUse, PostToolUse, UserPromptSubmit, SessionStart, Stop…).

## If you get stuck

Hook not firing? Restart Claude, then double-check the matcher and that the command runs standalone. On the sample app? Same exercise with its prettier/ruff setup.

---

← Previous: [Exercise 3 — TDD](./3-tdd-brownfield.md)  ·  Next: [Exercise 5 — Worktrees →](./5-worktrees-brownfield.md)
