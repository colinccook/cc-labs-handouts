`Greenfield track · Exercise 0 of 5` — [Welcome](./README.md)

# Exercise 0 — Set up your project and its context (greenfield)

**Track:** Greenfield — you're starting something new from an empty folder.
**Time:** ~30 min · **You'll leave with:** a running skeleton, a short product brief, and a CLAUDE.md that keeps Claude on the rails from here on.

> **The bigger picture:** these exercises aren't about *trying out* Claude Code — they're a build. Each one leaves a real artifact in your project, and by the end of day 2 you'll have a running thing **you** built, faster than you'd have built it alone. This first exercise lays the foundation everything else stacks on.

---

## Why this exercise

When you work with Claude on a real project, the quality of what it builds depends less on any single prompt and more on the **context** it carries into every message — your commands, your conventions, and the *why* behind your key decisions. Get that scaffolding right on day one and every later exercise (specs, TDD, hooks) builds on solid ground.

You don't have a repo yet, so this exercise does double duty: you'll use Claude to stand your project up **and** lay down its context files at the same time. You're not building features yet — you're building the launchpad.

> **One idea to hold onto:** your `CLAUDE.md` is a *table of contents, not an encyclopedia*. It stays thin and points at the detail (your brief, your decisions), rather than restating it.

## Before you start

- An empty folder, with `claude` running inside it.
- The idea you brought — it doesn't need to be fully formed. Claude will interview you to sharpen it just enough to get started.
- If your idea needs a language/runtime you haven't installed, have it ready (you already proved Node/uv/git during setup).

## Steps

**1. Start the interview.** Paste this — Claude will **interview you one question at a time**: what you're building, the smallest useful version of it, and your stack.

```text
I'm starting a new project from an empty folder and want to work with you agentically
over the next day and a half. I have an idea but nothing set up. Before we build any
features, help me stand up the project and its context harness.

Interview me first — one question at a time, wait for each answer — but only about what
you need to stand up the right skeleton and record why. Cover: what this is in a sentence
or two; the rough MVP shape (what's in, what's explicitly out — keep it small, it's a
1.5-day build); the stack (language, framework, package manager, does it need storage);
and any coding preferences, styles, or architecture conventions I want followed (these
seed .claude/rules/conventions.md). Don't lead with a default — make me commit first,
then tell me if you'd have chosen differently. When I don't know something, teach me the trade-off (2–3 options,
what each costs for a build this size) and make me pick. Do not get into detailed
features or acceptance criteria — we'll do that properly next.

When you've got enough — and not before — propose, and STOP for approval before creating anything:
1. docs/brief.md — a short product brief: the idea in a paragraph, MVP bullets,
   out-of-scope. (The north star — not a feature spec.)
2. A running skeleton for the stack we chose — hello-world that boots. No tests yet.
3. A thin root CLAUDE.md: how to run it, ~5 rules, and a "where the detail lives"
   section pointing at docs/brief.md.
4. .claude/rules/conventions.md — only this for now.
5. docs/adr/0001-initial-stack.md capturing the stack decision and the why I gave you,
   plus a tiny always-on architecture.md rule pointing at docs/adr/.

Show me the file tree and each file's contents, then stop.
```

**2. Answer honestly, and make the calls yourself.** When you don't know something, say so — Claude will lay out the trade-offs and let you choose. Those choices are what get recorded.

**3. Review the starter files before they're created.** Claude proposes a set of starter files and **stops for your approval**. Read them. Fix anything that's wrong. Only then let it create them.

## What good looks like

By the end you should have, and be able to point at:

- **`docs/brief.md`** — your idea and a *small* MVP, with an explicit "not doing this" list. This is your north star for the rest of the two days.
- **A skeleton that actually runs** — start it and see the hello-world. Nothing more; features come next.
- **A thin `CLAUDE.md`** that points at your brief rather than repeating it.
- **`docs/adr/0001-initial-stack.md`** — one page capturing *why* you chose your stack. This is the file that later stops Claude from quietly undoing a deliberate decision.

## Tips & watch-outs

> **💰 Token-smart:** your `CLAUDE.md` and always-on rules reload on *every* message — bloat here is a tax you pay all day. Keep it a table of contents, not an encyclopedia, and run `/context` before and after to watch the always-on cost drop.

- **Keep the MVP ruthlessly small.** A day and a half goes fast. The most valuable thing Claude can do in the interview is help you cut scope — let it.
- **Don't skip the "why."** When Claude asks why you chose something, give a real answer. That reasoning is what makes ADR-0001 worth having.
- **No tests yet — that's deliberate.** You'll stand up testing properly in the TDD exercise. A skeleton that just boots is exactly right for now.
- **Read before you approve.** The whole point of "stop for approval" is that you catch a wrong assumption while it's still free to fix.

## 🎁 Bonus — go further

Done early, or want to push it? Try any of these:

- **Prove the guardrail works.** Ask Claude to make a change that quietly contradicts your ADR-0001 decision (e.g. "swap the datastore" or "restructure the entry point"). With the `architecture.md` rule in place it should *push back* and point at the ADR instead of just doing it. That pushback is the whole payoff — see it fire.
- **Generate your README from the brief.** Ask Claude to write a first `README.md` (what this is, how to run it) *from* `docs/brief.md`, without duplicating it. Notice CLAUDE.md now has real docs to point at.
- **Add a personal preference.** Put a one-line style preference into `~/.claude/CLAUDE.md` (your *personal* file, loaded everywhere) — e.g. "explain your plan before large refactors." Team rules stay in the project; personal taste stays here.

---

← Previous: [Welcome](./README.md)  ·  Next: [Exercise 1 — Spec-driven development →](./1-spec-greenfield.md)
