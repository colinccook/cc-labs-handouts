`Greenfield track · Exercise 1 of 8` — [Welcome](../README.md)

# Exercise 1 — Set up your project and its context (greenfield)

**Track:** Greenfield — you're starting something new from an empty folder.
**Time:** ~30 min · **You'll leave with:** a running skeleton, a short product brief, and a `.github/copilot-instructions.md` that keeps Copilot on the rails from here on.

> **The bigger picture:** these exercises aren't about *trying out* Copilot CLI — they're a build. Each one leaves a real artifact in your project, and by the end of day 2 you'll have a running thing **you** built, faster than you'd have built it alone. This first exercise lays the foundation everything else stacks on.

> **Default model & effort:** unless a step says otherwise, run on **Claude Sonnet** (the Copilot CLI default) at **high reasoning effort** — set both in **`/model`**, or launch with `copilot --effort high`. That's the recommended default across these exercises. Try other models and effort levels as you go; the right choice depends on the task (Exercise 6's cheap Haiku reviewer is the one deliberate exception). Save top-tier, high-multiplier models (Opus-class) for when a step asks for them — `/model` shows each model's cost, `/usage` shows what you've spent.

---

## Why this exercise

When you work with Copilot on a real project, the quality of what it builds depends less on any single prompt and more on the **context** it carries into every message — your commands, your conventions, and the *why* behind your key decisions. Get that scaffolding right on day one and every later exercise (specs, TDD, hooks) builds on solid ground.

You don't have a repo yet, so this exercise does double duty: you'll use Copilot to stand your project up **and** lay down its context files at the same time. You're not building features yet — you're building the launchpad.

> **One idea to hold onto:** your `.github/copilot-instructions.md` is a *table of contents, not an encyclopedia*. It stays thin and points at the detail (your brief, your decisions), rather than restating it.

### How Copilot CLI loads context

| File | When it loads | Use it for |
|---|---|---|
| `.github/copilot-instructions.md` | Every message, in every session in this repo | The thin table of contents: commands, a handful of always-true rules, pointers |
| `.github/instructions/<name>.instructions.md` with `applyTo: "<glob>"` | When Copilot reads or edits a file matching the glob (`"**"` = any file) | Focused rule sets — conventions, architecture, an area of the code |
| `~/.copilot/copilot-instructions.md` | Every session, every repo | *Your* personal preferences — not the team's |

Copilot CLI also understands `AGENTS.md` (the cross-tool standard) — use it instead of `copilot-instructions.md` if your team mixes agents. Pick **one** root file; don't keep both.

## Before you start

- An empty folder, `git init`-ed, with `copilot` running inside it.
- The idea you brought — it doesn't need to be fully formed. Copilot will interview you to sharpen it just enough to get started.
- If your idea needs a language/runtime you haven't installed, have it ready (you already proved Node/uv/git during setup).

## Steps

**1. Start the interview.** Paste this — Copilot will **interview you one question at a time**: what you're building, the smallest useful version of it, and your stack.

```text
I'm starting a new project from an empty folder and want to work with you agentically
over the next day and a half. I have an idea but nothing set up. Before we build any
features, help me stand up the project and its context harness.

Interview me first — one question at a time, wait for each answer — but only about what
you need to stand up the right skeleton and record why. Cover: what this is in a sentence
or two; the rough MVP shape (what's in, what's explicitly out — keep it small, it's a
1.5-day build); the stack (language, framework, package manager, does it need storage);
and any coding preferences, styles, or architecture conventions I want followed (these
seed .github/instructions/conventions.instructions.md). Don't lead with a default — make
me commit first, then tell me if you'd have chosen differently. When I don't know
something, teach me the trade-off (2–3 options, what each costs for a build this size)
and make me pick. Do not get into detailed features or acceptance criteria — we'll do
that properly next.

When you've got enough — and not before — propose, and STOP for approval before creating
anything:
1. docs/brief.md — a short product brief: the idea in a paragraph, MVP bullets,
   out-of-scope. (The north star — not a feature spec.)
2. A running skeleton for the stack we chose — hello-world that boots. No tests yet.
3. A thin .github/copilot-instructions.md: how to run it, ~5 rules, and a "where the
   detail lives" section pointing at docs/brief.md by plain path (not an @-import).
4. .github/instructions/conventions.instructions.md with applyTo: "**" — only this for now.
5. docs/adr/0001-initial-stack.md capturing the stack decision and the why I gave you,
   plus a tiny .github/instructions/architecture.instructions.md (applyTo: "**") that
   points at docs/adr/ as the home for decisions AND says when a new ADR is required —
   breaking changes and decisions costly to reverse. Reference it from
   copilot-instructions.md.

Show me the file tree and each file's contents, then stop.
```

**2. Answer honestly, and make the calls yourself.** When you don't know something, say so — Copilot will lay out the trade-offs and let you choose. Those choices are what get recorded.

**3. Review the starter files before they're created.** Copilot proposes a set of starter files and **stops for your approval**. Read them. Fix anything that's wrong. Only then let it create them. (Copilot will also ask permission before running shell commands — read those prompts too, rather than reflexively approving everything for the session.)

**4. Load your new context.** Instruction files are read when a session starts, so changes aren't picked up mid-conversation. Run `/clear` (or `/new`) to start a fresh conversation, then `/instructions` to confirm both instruction files are listed and enabled.

## What good looks like

By the end you should have, and be able to point at:

- **`docs/brief.md`** — your idea and a *small* MVP, with an explicit "not doing this" list. This is your north star for the rest of the two days.
- **A skeleton that actually runs** — start it and see the hello-world. Nothing more; features come next.
- **A thin `.github/copilot-instructions.md`** that points at your brief rather than repeating it.
- **`docs/adr/0001-initial-stack.md`** — one page capturing *why* you chose your stack. This is the file that later stops Copilot from quietly undoing a deliberate decision.

## Tips & watch-outs

> **💰 Token-smart:** your `copilot-instructions.md` and any `applyTo: "**"` instructions ride along with *every* message — bloat here is a tax you pay all day. It's a balancing act: too little and Copilot guesses, too much and the rules that matter get lost in the noise. Keep it a table of contents, not an encyclopedia. Run `/context` to see what's in the window; if you trim the file, `/clear` (so the new version loads) and run `/context` again to watch that number drop.

- **Know your controls.** `/model` switches model *and* reasoning effort (`low` → `max`, depending on the model). There's no `ultrathink`-style keyword in Copilot CLI — for a one-off deeper pass, raise the effort in `/model` for that step and drop it back afterwards, or ask `/rubber-duck` for a critique from a complementary model. You'll pick models per step as you go — a stronger model for specs, Haiku for the cheap review later.
- **Link, don't `@`-import.** Copilot instructions support `@path` imports, but an import *inlines* the whole file into every message. A plain path ("see `docs/brief.md`") lets Copilot read it only when it's relevant — that's what keeps the table of contents thin.
- **`applyTo: "**"` isn't quite "always".** Path-specific instructions attach when Copilot works with a matching file. A rule that must hold *before* any file is touched (like "stop for approval") belongs in `copilot-instructions.md` itself.
- **Keep the MVP ruthlessly small.** A day and a half goes fast. The most valuable thing Copilot can do in the interview is help you cut scope — let it.
- **Don't skip the "why."** When Copilot asks why you chose something, give a real answer. That reasoning is what makes ADR-0001 worth having.
- **No tests yet — that's deliberate.** You'll stand up testing properly in the TDD exercise. A skeleton that just boots is exactly right for now.
- **Read before you approve.** The whole point of "stop for approval" is that you catch a wrong assumption while it's still free to fix.

## 🎁 Bonus — go further

Done early, or want to push it? Try any of these:

- **Prove the guardrail works.** Ask Copilot to make a change that quietly contradicts your ADR-0001 decision (e.g. "swap the datastore" or "restructure the entry point"). With the architecture instructions in place it should *push back* and point at the ADR instead of just doing it. If it doesn't, strengthen the rule with a `YOU MUST` / `IMPORTANT` directive (or move it into `copilot-instructions.md` so it's in context before any file is touched), `/clear`, and try again — notice how much harder the model leans on the emphatic phrasing. That pushback is the whole payoff.
- **Generate your README from the brief.** Ask Copilot to write a first `README.md` (what this is, how to run it) *from* `docs/brief.md`, without duplicating it. Notice `copilot-instructions.md` now has real docs to point at.
- **Add a personal preference.** Put a one-line style preference into `~/.copilot/copilot-instructions.md` (your *personal* file, loaded in every repo) — e.g. "explain your plan before large refactors." Team rules stay in the project; personal taste stays here.

---

← Previous: [Welcome](../README.md)  ·  Next: [Exercise 2 — Spec-driven development →](./2-spec-greenfield.md)
