`Brownfield track · Exercise 4 of 8` — [Welcome](./README.md)

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

## Steps

**1. Confirm the command first.** Run your exact formatter command in a plain terminal to confirm it works — this prevents 90% of hook pain.

**2. Wire the format hook (and, optionally, a test hook).** Paste this to add a `PostToolUse` format hook — and optionally a `Stop` hook that runs your tests so "done" is machine-checked:

```text
Add one PostToolUse hook to .claude/settings.json that runs my formatter on files you edit (e.g. prettier / ruff / gofmt). First tell me the exact command to confirm in my terminal, then wire it scoped to the file types it applies to. Explain that hooks run arbitrary shell with my permissions.

Bonus: add a Stop hook that runs my test command (the one from Exercise 3) so "done" is machine-checked, not vibes.
```

**3. Watch it fire.** Hook config is picked up automatically (a file watcher reloads it — no restart needed). Edit a file and watch the hook run. If it doesn't fire, check the matcher in `/hooks`.

## What good looks like

- **A format hook** that fires automatically after Claude edits a matching file — you never ask it to format again.
- **(Optional) a `Stop` hook** running your suite, so a session can't quietly end on red.
- The commands are scoped and fast enough not to drag every turn.

## Tips & watch-outs

- **Test the command in a plain terminal first** — a wrong command string is the #1 cause of hook pain.
- **Hook changes reload automatically** (file watcher) — no restart needed. If one doesn't fire, check `/hooks`.
- **Heavy hooks slow the loop** — scope the test hook to changed files if your suite is slow.
- **Re-read the security note** before wiring anything.

## 🎁 Bonus — go further

- **Protect a path.** Add a `PreToolUse` hook that blocks edits to a sensitive file/dir (secrets, generated code) — a guardrail Claude *can't* talk its way past.
- **Get notified.** Add a completion notification (desktop/Slack) so you know when a long run finishes.
- **Browse `/hooks`** to see every lifecycle event (PreToolUse, PostToolUse, UserPromptSubmit, SessionStart, Stop…).

---

← Previous: [Exercise 3 — TDD](./3-tdd-brownfield.md)  ·  Next: [Exercise 5 — Worktrees →](./5-worktrees-brownfield.md)
