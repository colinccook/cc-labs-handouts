`Greenfield track · Exercise 3 of 7` — [Welcome](./README.md)

# Exercise 3 — Turn your workflow into a skill (greenfield)

**Track:** Greenfield · **Time:** ~25 min
**Builds on:** the spec-drafting from Exercise 2. · **Adds to your build:** a reusable `/specify` skill — and a spec ready to build in Exercise 4.

> **Why it matters:** a skill captures *the way you do X here* once, so it fires automatically whenever a matching task comes up. On a new project you'll draft specs over and over — so that's the first thing worth capturing.

---

## Why this exercise

You'll turn last exercise's spec-drafting prompt into a one-keystroke `/specify` skill. The point isn't "what is a skill" (you've seen that) — it's capturing the work you'll repeat most, so the loop gets faster every pass.

## Before you start

- Exercise 2 done — you've got a `specs/_template.md` and a spec-drafting flow fresh in mind.
- `docs/brief.md` and `.claude/rules/conventions.md` from Exercise 1.

## Steps

**1. Build the `/specify` skill.** Capture your spec-drafting workflow as a reusable, self-contained skill — the prompt spells out every step so it works even in a fresh session with no prior context.

```text
Create a skill at .claude/skills/specify/SKILL.md that drafts a feature spec for this
project. It must be self-contained — assume a fresh session with no prior conversation.
Frontmatter: name; a specific description listing trigger phrases ("write a spec", "spec
this slice", "specify ..."); argument-hint: <feature>; and set model: opus with effort:
high — spec quality is worth the strongest model (if I don't have Opus access it falls back
to my session model). Body — the steps to run when invoked: (1) read docs/brief.md,
docs/adr/, and any code the slice touches; (2) open specs/_template.md, creating a lean one
if it's missing; (3) fill every section — holding scope to one slice and respecting the
brief's out-of-scope list — asking me one question at a time for anything you can't infer;
(4) write to specs/<kebab-feature>.md; (5) STOP for review — do NOT write implementation.
Show me the finished SKILL.md and stop.
```

*(If the per-skill model override doesn't take effect in your setup, just run `/model opus` before `/specify`.)*

**2. Trigger it two ways.** Run it explicitly with `/specify <slice>`, and also **describe the task in plain language** — without naming the skill — to confirm its `description` fires it on its own.

**3. Spec the slice you'll build next.** Use your new `/specify` to draft a spec for the **next small slice** of your brief — one you'll implement test-first in Exercise 4. Edit it until the acceptance criteria are concrete. You'll walk into the next exercise with a spec in hand.

## What good looks like

- **`/specify <slice>`** drafts a spec in one keystroke.
- It **fires when you describe its task** in plain language, not only when you type `/specify`.
- **A spec ready for Exercise 4**, with testable acceptance criteria.

## Tips & watch-outs

> **💰 Token-smart:** skills load *progressively* — a skill's description sits in context every turn so Claude knows it's there, but the full instructions load only when it fires. Keep descriptions tight. For a skill you'll only ever trigger yourself, `disable-model-invocation: true` keeps even its description out of the way until you call it.

- **The `description` is the trigger** — specific and slightly pushy. The model under-triggers by default.
- **Keep `SKILL.md` tight**; push detail to a `references/` file it reads on demand.
- **You don't have to build these from scratch.** Whole AI-native SDD kits already exist — e.g. [spec-kit](https://github.com/github/spec-kit) and [specs.md](https://specs.md/) — collections of ready-made skills and agents, usually agnostic to the model or coding tool. We're hand-rolling one here to see how it works; in real life you'd often start from one of those.

## 🎁 Bonus — go further

- **Try the built-in skills — no install.** `/simplify` cleans up code you just wrote without changing behaviour; `/security-review` scans your new code for vulnerabilities. Both ship with Claude Code.
- **Tune your skill's frontmatter.** Add an `argument-hint` so `/specify` shows its usage as you type it, and try `disable-model-invocation: true` on a skill you only ever call yourself — it drops the skill's idle context cost to zero until you invoke it by name.
- **Capture a scaffold skill.** As your MVP grows you'll stamp out the same kind of piece — a component, an endpoint, a module — again and again. When you notice that pattern, capture it as a skill that scaffolds one to your `conventions.md` (you know the shape now — no prompt needed). Do this once the repetition is *real*, not before.

---

← Previous: [Exercise 2 — Spec-driven](./2-spec-greenfield.md)  ·  Next: [Exercise 4 — TDD →](./4-tdd-greenfield.md)
