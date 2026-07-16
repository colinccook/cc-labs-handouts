`Brownfield track · Exercise 2 of 8` — [Overview & index](./README.md)

# Exercise 2 — Turn your workflow into a skill (brownfield)

**Track:** Brownfield · **Time:** ~30 min
**Builds on:** the spec-drafting you did by hand in Exercise 1. · **Adds to your build:** a `/specify` skill, plus one skill for a task you repeat.

> **Why it matters:** a skill captures *the way you do X here* once, so it persists across sessions and teammates — and fires automatically when a task matches. In Exercise 1 you typed a paragraph to make Claude draft a spec. You'll type it again every feature… unless you capture it.

---

## Why this exercise

You'll build two skills. First `/specify` — turning last exercise's repetitive spec-drafting prompt into one keystroke. Then one for a task *you* do the same way every time. The point isn't "what is a skill" (you've seen that) — it's building skills for **your** real, repeated work.

## Before you start

- Exercise 1 done — you have the spec-drafting prompt fresh in mind.
- A task in your repo you do identically each time (a component, a migration, a PR write-up…).

## What you'll do

1. **Part A** — build `/specify` from your Exercise-1 prompt.
2. **Part B** — build a second skill for one of your repeated tasks.
3. Trigger each **naturally** (describe the task; don't name the skill) and confirm it fires.

## The prompts

**Part A — capture the spec-drafting prompt:**

> In Exercise 1 I typed a paragraph to make you draft a spec, and I'll retype it every feature. Capture it once as a skill at `.claude/skills/specify/SKILL.md`: frontmatter (`name`, `description`, `argument-hint`) plus the spec-drafting steps — read the touched code and `docs/adr/` first, fill `specs/_template.md`, write to `specs/<kebab-feature>.md`, and STOP for review without writing implementation. Then let me run `/specify <a feature>` to test it.

**Part B — a skill for something you repeat:**

> Think of a task in this repo you do identically each time — scaffolding a component, a migration, a PR description, a test file. Create `.claude/skills/<name>/SKILL.md` capturing my exact steps and conventions. Then I'll trigger it **naturally** (without naming the skill) to check the `description` fires it.

## What good looks like

- **`/specify <feature>`** does in one keystroke what took a paragraph last exercise.
- **A second skill** that fires when you *describe* its task — no need to name it.
- Both are files in `.claude/skills/` you can share with teammates.

## Tips & watch-outs

- **The `description` is the trigger.** Make it specific and slightly pushy — list the phrases that should fire it. The model tends to *under*-trigger skills.
- **Keep `SKILL.md` under ~500 lines**; push detail into a `references/` file it reads only when needed.
- **Best candidates:** anything with a fixed sequence of steps, org conventions, or "the boring bit."

## 🎁 Bonus — go further

- **Install one, don't reinvent it.** Add the official marketplace and try `simplify` (the cleanup skill Anthropic's own team uses): `/plugin marketplace add anthropics/claude-plugins-official` → `/plugin install simplify@claude-plugins-official` → `/reload-plugins`. Run it on some messy code.
- **Run `/security-review`** (built in, no install) on your working changes.
- **Add an `argument-hint`** to `/specify` so it shows usage as you type it.

## If you get stuck

If a skill won't trigger, the `description` is too vague — rewrite it with the exact phrases you'd naturally say. On the sample app? Same exercise, same skills.

---

← Previous: [Exercise 1 — Spec-driven](./1-spec-brownfield.md)  ·  Next: [Exercise 3 — TDD →](./3-tdd-brownfield.md)
