`Brownfield track · Exercise 8 of 8 · showcase` — [Welcome](./README.md)

# Exercise 8 — Let it run without you (brownfield)

**Track:** Brownfield · *Showcase — mostly watch, one thing to run* · **Time:** ~15 min
**Builds on:** the CLAUDE.md, specs, and hooks you built all workshop. · **Takeaway:** the workflow files, to wire up after the day.

> **Why it matters:** everything so far had you in the loop. This flips it — the same `claude` binary runs with **no human**, triggered by a push, a PR comment, or a nightly cron. It reads a prompt, does the work, and emits a result the pipeline acts on. The rules you'll set for it are exactly the CLAUDE.md, specs, and hooks you've been building.

---

## Why this is a showcase, not a full hands-on

Wiring CI needs an API key in secrets, repo admin, and a few minutes of GitHub plumbing *per person* — not workshop-friendly at 30 people. So you'll watch it work on a pre-baked repo and take the workflow files home. But there's **one line you can run right now**, no setup.

## Run it yourself (the "it's just Unix" moment)

In your repo, on a branch with changes:

```bash
git diff origin/main...HEAD | claude -p "Review this diff. List the top 3 risks. Max 8 lines."
```

That's headless Claude: `-p` runs the full agent loop once and prints the result. If it runs in a shell, it runs in your CI.

## What you'll see demoed

- **`/install-github-app`** → the `anthropics/claude-code-action@v1` workflow reviewing a PR inline.
- **`@claude` mentions** — comment `@claude fix the error handling here` on an issue/PR and it opens a branch with the change.
- **A nightly `cron`** running `/security-review` and uploading findings as a JSON artifact.

## Take it home

- The workflow YAML files (PR review + nightly audit) are yours to copy.
- Try `/install-github-app` on a repo you own after the workshop.
- Useful headless one-liners: changelog from commits, flag tech-debt, auto-fix a failing test on a branch.

> **💰 Token-smart:** `--max-turns`, `--allowedTools`, a cheaper `--model`, and piping only the diff (not the whole repo) are what keep an unattended run from quietly running up a bill.

## Guardrails (so nobody does something scary Monday)

- **API key is always a CI secret** — never in the workflow file or logs.
- **`--dangerously-skip-permissions` is for isolated CI containers only** — never your dev machine.
- **Scope tightly:** pipe only the diff, cap with `--max-turns` and `--allowedTools`, or costs run away.
- **It augments your tests/linters, it doesn't replace them** — keep the deterministic net.

> **Landing line:** *"Today you learned to drive it. This is what it looks like when it starts driving itself — with you setting the rules."*

---

← Previous: [Exercise 7 — MCP](./7-mcp-brownfield.md)  ·  [Back to Welcome →](./README.md)
