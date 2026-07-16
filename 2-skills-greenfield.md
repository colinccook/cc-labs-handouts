`Greenfield track · Exercise 2 of 8` — [Overview & index](./README.md)

# Exercise 2 — Turn your workflow into a skill (greenfield)

**Track:** Greenfield · **Time:** ~30 min
**Builds on:** the spec-drafting from Exercise 1. · **Adds to your build:** a `/specify` skill, plus a scaffold skill for your project.

> **Why it matters:** a skill captures *the way you do X here* once, so it fires automatically whenever a matching task comes up. On a new project the two things you'll do over and over are **drafting specs** and **scaffolding new pieces** — so those are exactly what to capture.

---

## Why this exercise

You'll build two skills. First `/specify` — last exercise's spec-drafting prompt as one keystroke. Then a **scaffold skill** that stamps out a new component/endpoint/module following the conventions you set in Exercise 0 — because you'll be doing that a lot as your MVP grows.

## Before you start

- Exercise 1 done — the spec-drafting prompt is fresh.
- `.claude/rules/conventions.md` from Exercise 0 (your scaffold skill will follow it).

## What you'll do

1. **Part A** — build `/specify` from your Exercise-1 prompt.
2. **Part B** — build a scaffold skill for the kind of thing you keep creating.
3. Trigger each **naturally** (describe the task; don't name the skill) and confirm it fires.

## The prompts

**Part A — capture the spec-drafting prompt:**

```text
In Exercise 1 I typed a paragraph to make you draft a spec, and I'll retype it for every
slice of my MVP. Capture it once as a skill at .claude/skills/specify/SKILL.md:
frontmatter (name, description, argument-hint) plus the spec-drafting steps — read
docs/brief.md, docs/adr/, and any code the slice touches first, fill specs/_template.md,
write to specs/<kebab-feature>.md, and STOP for review without writing implementation.
Then let me run /specify <next slice> to test it.
```

**Part B — capture your project's repetitive scaffold:**

```text
A new project means I'll create the same kind of thing over and over — a new component /
endpoint / module following the conventions in .claude/rules/conventions.md. Create
.claude/skills/<name>/SKILL.md that scaffolds one to my conventions (right folder,
naming, boilerplate). Then I'll trigger it naturally (without naming the skill) to check
it fires.
```

## What good looks like

- **`/specify <slice>`** drafts a spec in one keystroke.
- **A scaffold skill** that produces a new project piece matching your conventions — try it and see a correctly-shaped file appear.
- Both live in `.claude/skills/` and will speed up the rest of your build.

## Tips & watch-outs

- **The `description` is the trigger** — specific and slightly pushy. The model under-triggers by default.
- **The scaffold skill is the high-value one here** — it compounds every time your project grows a new piece.
- **Keep `SKILL.md` tight**; push detail to a `references/` file it reads on demand.

## 🎁 Bonus — go further

- **Install one, don't reinvent it.** `/plugin marketplace add anthropics/claude-plugins-official` → `/plugin install simplify@claude-plugins-official` → `/reload-plugins`, then run `simplify` on code you've written.
- **Run `/security-review`** on your new code (built in, no install).
- Give `/specify` an `argument-hint` so it self-documents.

---

← Previous: [Exercise 1 — Spec-driven](./1-spec-greenfield.md)  ·  Next: [Exercise 3 — TDD →](./3-tdd-greenfield.md)
