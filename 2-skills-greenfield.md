`Greenfield track · Exercise 2 of 8` — [Welcome](./README.md)

# Exercise 2 — Turn your workflow into a skill (greenfield)

**Track:** Greenfield · **Time:** ~30 min
**Builds on:** the spec-drafting from Exercise 1. · **Adds to your build:** a `/specify` skill, plus a scaffold skill for your project.

> **Why it matters:** a skill captures *the way you do X here* once, so it fires automatically whenever a matching task comes up. On a new project the two things you'll do over and over are **drafting specs** and **scaffolding new pieces** — so those are exactly what to capture.

---

## Why this exercise

You'll build two skills. First `/specify` — last exercise's spec-drafting prompt as one keystroke. Then a **scaffold skill** that stamps out a new component/endpoint/module following the conventions you set in Exercise 0 — because you'll be doing that a lot as your MVP grows.

## Before you start

- Exercise 1 done — you've got a `specs/_template.md` and a spec-drafting flow fresh in mind.
- `.claude/rules/conventions.md` from Exercise 0 (your scaffold skill will follow it).

## Steps

**1. Build the `/specify` skill.** Capture your spec-drafting workflow as a reusable, self-contained skill — the prompt spells out every step so it works even in a fresh session with no prior context. When it's created, test it with `/specify <next slice>`.

```text
Create a skill at .claude/skills/specify/SKILL.md that drafts a feature spec for this
project. It must be self-contained — assume a fresh session with no prior conversation.
Frontmatter: name; a specific description listing trigger phrases ("write a spec", "spec
this slice", "specify ..."); and argument-hint: <feature>. Body — the steps to run when
invoked: (1) read docs/brief.md, docs/adr/, and any code the slice touches; (2) open
specs/_template.md, creating a lean one if it's missing; (3) fill every section — holding
scope to one slice and respecting the brief's out-of-scope list — asking me one question at
a time for anything you can't infer; (4) write to specs/<kebab-feature>.md; (5) STOP for
review — do NOT write implementation. Show me the finished SKILL.md and stop.
```

**2. Capture a scaffold skill.** First decide what you'll keep creating as the MVP grows — a component, an endpoint, a module. Then paste this, naming that thing:

```text
I'll create the same kind of thing over and over in this project — a new
<component / endpoint / module> — and I want a skill that scaffolds one to my conventions.
Read .claude/rules/conventions.md, then create .claude/skills/<name>/SKILL.md that stamps
out a new one in the right folder, with the right naming and boilerplate. Frontmatter:
name; a specific description listing the phrases that should trigger it; and an
argument-hint for the name of the thing. Keep SKILL.md tight — put any long detail in a
references/ file it reads on demand. Show me the file and stop.
```

**3. Trigger each skill two ways.** Run it explicitly by its `/command`, and also **describe the task in plain language** — without naming the skill — to confirm its `description` fires it on its own.

## What good looks like

- **`/specify <slice>`** drafts a spec in one keystroke.
- **A scaffold skill** that produces a new project piece matching your conventions — try it and see a correctly-shaped file appear when you *describe* the task, not just when you directly invoke it.
- Both live in `.claude/skills/` and will speed up the rest of your build.

## Tips & watch-outs

- **The `description` is the trigger** — specific and slightly pushy. The model under-triggers by default.
- **The scaffold skill is the high-value one here** — it compounds every time your project grows a new piece.
- **Keep `SKILL.md` tight**; push detail to a `references/` file it reads on demand.
- **You don't have to build these from scratch.** Whole AI-native SDD kits already exist — e.g. [spec-kit](https://github.com/github/spec-kit) and [specs.md](https://specs.md/) — collections of ready-made skills and agents, usually agnostic to the model or coding tool. We're hand-rolling one here to see how it works; in real life you'd often start from one of those.

## 🎁 Bonus — go further

- **Install one, don't reinvent it.** `/plugin marketplace add anthropics/claude-plugins-official` → `/plugin install simplify@claude-plugins-official` → `/reload-plugins`, then run `simplify` on code you've written.
- **Run `/security-review`** on your new code (built in, no install).
- Give `/specify` an `argument-hint` so it self-documents.

---

← Previous: [Exercise 1 — Spec-driven](./1-spec-greenfield.md)  ·  Next: [Exercise 3 — TDD →](./3-tdd-greenfield.md)
