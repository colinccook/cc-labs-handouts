`Greenfield track · Exercise 8 of 8 · showcase` — [Welcome](./README.md)

# Exercise 8 — Let it run without you (greenfield)

**Track:** Greenfield · *Showcase — mostly watch, one thing to run* · **Time:** ~15 min
**Builds on:** the whole project you just built. · **Takeaway:** the workflow files, to wire up after the day.

> **Why it matters:** everything so far had you in the loop. This flips it — the same `claude` binary runs with **no human**, triggered by a push, a PR comment, or a nightly cron. Your brand-new repo is actually a *clean* stage for this: you could have automated review from commit one.

---

## Why this is a showcase, not a full hands-on

CI needs an API key in secrets, repo admin, and GitHub plumbing per person — not workshop-friendly at 30 people. So you'll watch it on a pre-baked repo and take the files home. But there's **one line you can run right now**.

## Run it yourself (the "it's just Unix" moment)

In your project, on a branch with changes:

```bash
git diff | claude -p "Review the changes on this branch. List the top 3 risks. Max 8 lines."
```

That's headless Claude: `-p` runs the full agent loop once and prints the result. If it runs in a shell, it runs in your CI.

## What you'll see demoed

- **`/install-github-app`** → the `anthropics/claude-code-action@v1` workflow reviewing a PR inline (nice for a fresh repo: automated review from commit 1).
- **`@claude` mentions** opening a fix branch from an issue/PR comment.
- **A nightly `cron`** running `/security-review` → JSON artifact.

## Take it home

- The workflow YAML files are yours to copy.
- Try `/install-github-app` once your prototype is on a repo you own.
- Useful one-liners: changelog from commits, flag tech-debt, auto-fix a failing test.

## Guardrails (so nobody does something scary Monday)

- **API key is always a CI secret** — never in the workflow file or logs.
- **`--dangerously-skip-permissions` is for isolated CI containers only.**
- **Scope tightly:** pipe only the diff, cap with `--max-turns` / `--allowedTools`.
- **It augments your tests/linters, it doesn't replace them.**

> **Landing line:** *"Today you learned to drive it. This is what it looks like when it starts driving itself — with you setting the rules."*

---

← Previous: [Exercise 7 — MCP](./7-mcp-greenfield.md)  ·  [Back to Welcome →](./README.md)
