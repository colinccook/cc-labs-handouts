`Brownfield track · Exercise 3 of 7` — [Welcome](./README.md)

# Exercise 3 — Turn your workflow into a skill (brownfield)

**Track:** Brownfield · **Time:** ~25 min
**Builds on:** the spec-drafting you did by hand in Exercise 2. · **Adds to your build:** a reusable `/specify` skill — and a spec ready to build in Exercise 4.

> **Why it matters:** a skill captures *the way you do X here* once, so it persists across sessions and teammates — and fires automatically when a task matches. In Exercise 2 you typed a paragraph to make Claude draft a spec. You'll type it again every feature… unless you capture it.

---

## Why this exercise

You'll turn last exercise's repetitive spec-drafting prompt into a one-keystroke `/specify` skill. The point isn't "what is a skill" (you've seen that) — it's capturing *your* real, repeated work so the loop gets faster every pass.

## Before you start

- Exercise 2 done — you've got a `specs/_template.md` and a spec-drafting flow fresh in mind.

## Steps

**1. Build the `/specify` skill.** Capture your spec-drafting workflow as a reusable, self-contained skill — the prompt spells out every step so it works even in a fresh session with no prior context.

```text
Create a skill at .claude/skills/specify/SKILL.md that drafts a feature spec for this
repo. It must be self-contained — assume a fresh session with no prior conversation.
Frontmatter: name; a specific description that lists trigger phrases ("write a spec",
"spec this feature", "specify ..."); argument-hint: <feature>; and set model: opus with
effort: high — spec quality is worth the strongest model (if I don't have Opus access it
falls back to my session model). Body — the steps to run when invoked: (1) read the code
the feature touches and docs/adr/ so the spec reflects reality and respects past decisions;
(2) open specs/_template.md, creating a lean one if it's missing; (3) fill every section,
asking me one question at a time for anything you can't confidently infer; (4) write the
result to specs/<kebab-feature>.md; (5) STOP for review — do NOT write any implementation.
Show me the finished SKILL.md and stop.
```

**2. Trigger it two ways.** Run it explicitly with `/specify <feature>`, and also **describe the task in plain language** — without naming the skill — to confirm its `description` fires it on its own.

**3. Spec the task you'll build next.** Use your new `/specify` to draft a spec for a **small, testable task** you'll implement test-first in Exercise 4. Edit it until the acceptance criteria are concrete. You'll walk into the next exercise with a spec in hand.

## What good looks like

- **`/specify <feature>`** does in one keystroke what took a paragraph last exercise.
- It **fires when you describe its task** in plain language, not only when you type `/specify`.
- **A spec ready for Exercise 4**, with testable acceptance criteria.

## Tips & watch-outs

> **💰 Token-smart:** skills load *progressively* — a skill's description sits in context every turn so Claude knows it's there, but the full instructions load only when it fires. Keep descriptions tight. For a skill you'll only ever trigger yourself, `disable-model-invocation: true` keeps even its description out of the way until you call it.

- **The `description` is the trigger.** Make it specific and slightly pushy — list the phrases that should fire it. The model tends to *under*-trigger skills.
- **Keep `SKILL.md` under ~500 lines**; push detail into a `references/` file it reads only when needed.
- **You don't have to build these from scratch.** Whole AI-native SDD kits already exist — e.g. [spec-kit](https://github.com/github/spec-kit) and [specs.md](https://specs.md/) — collections of ready-made skills and agents, usually agnostic to the model or coding tool. We're hand-rolling one here to see how it works; in real life you'd often start from one of those.

## 🎁 Bonus — go further

- **Try the built-in skills — no install.** `/simplify` does a focused cleanup pass over code you just wrote (removes duplication, flattens nested conditionals, clarifies logic) *without changing behaviour* — the pass Anthropic's own team uses. `/security-review` scans your working changes for vulnerabilities and suggests fixes. Both ship with Claude Code — run them on some messy code.
- **Tune your skill's frontmatter.** Add an `argument-hint` so `/specify` shows its usage as you type it, and try `disable-model-invocation: true` on a skill you only ever call yourself — it drops the skill's idle context cost to zero until you invoke it by name.
- **Capture a skill for your own repeated work.** If there's a task you do the *exact* same way every time — scaffolding a component, a migration, a PR write-up — capture it as a skill the same way you built `/specify` (you know the shape now — no prompt needed). If nothing in your repo is genuinely repetitive, skip this; don't build a skill for its own sake.

---

← Previous: [Exercise 2 — Spec-driven](./2-spec-brownfield.md)  ·  Next: [Exercise 4 — TDD →](./4-tdd-brownfield.md)
