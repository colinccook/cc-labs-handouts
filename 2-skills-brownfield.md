`Brownfield track · Exercise 2 of 8` — [Welcome](./README.md)

# Exercise 2 — Turn your workflow into a skill (brownfield)

**Track:** Brownfield · **Time:** ~30 min
**Builds on:** the spec-drafting you did by hand in Exercise 1. · **Adds to your build:** a `/specify` skill, plus one skill for a task you repeat.

> **Why it matters:** a skill captures *the way you do X here* once, so it persists across sessions and teammates — and fires automatically when a task matches. In Exercise 1 you typed a paragraph to make Claude draft a spec. You'll type it again every feature… unless you capture it.

---

## Why this exercise

You'll build two skills. First `/specify` — turning last exercise's repetitive spec-drafting prompt into one keystroke. Then one for a task *you* do the same way every time. The point isn't "what is a skill" (you've seen that) — it's building skills for **your** real, repeated work.

## Before you start

- Exercise 1 done — you've got a `specs/_template.md` and a spec-drafting flow fresh in mind.
- A task in your repo you do identically each time (a component, a migration, a PR write-up…).

## Steps

**1. Build the `/specify` skill.** Capture your spec-drafting workflow as a reusable, self-contained skill — the prompt spells out every step so it works even in a fresh session with no prior context. When it's created, test it with `/specify <a feature>`.

```text
Create a skill at .claude/skills/specify/SKILL.md that drafts a feature spec for this
repo. It must be self-contained — assume a fresh session with no prior conversation.
Frontmatter: name; a specific description that lists trigger phrases ("write a spec",
"spec this feature", "specify ..."); and argument-hint: <feature>. Body — the steps to run
when invoked: (1) read the code the feature touches and docs/adr/ so the spec reflects
reality and respects past decisions; (2) open specs/_template.md, creating a lean one if
it's missing; (3) fill every section, asking me one question at a time for anything you
can't confidently infer; (4) write the result to specs/<kebab-feature>.md; (5) STOP for
review — do NOT write any implementation. Show me the finished SKILL.md and stop.
```

**2. Capture a second skill — something you repeat.** First pick a task in your repo you do identically each time (scaffolding a component, a migration, a PR description, a test file). Then paste this, describing that task and its exact steps:

```text
I want to capture a task I do the same way every time as a reusable skill. The task is:
<describe the task, plus the exact steps and conventions you follow>. Create
.claude/skills/<name>/SKILL.md with frontmatter (name; a specific description listing the
phrases that should trigger it; an argument-hint if it takes input) and a body with my
exact steps. Keep SKILL.md tight — if there's a lot of detail, put it in a references/
file the skill reads on demand. Show me the file and stop.
```

**3. Trigger each skill two ways.** Run it explicitly by its `/command`, and also **describe the task in plain language** — without naming the skill — to confirm its `description` fires it on its own.

## What good looks like

- **`/specify <feature>`** does in one keystroke what took a paragraph last exercise.
- **A second skill** that fires when you *describe* its task — not just when you directly invoke it.
- Both are files in `.claude/skills/` you can share with teammates.

## Tips & watch-outs

> **💰 Token-smart:** skills load *progressively* — a skill's description sits in context every turn so Claude knows it's there, but the full instructions load only when it fires. Install what you'll use, not everything: `/plugin`'s details pane shows a **context-cost estimate** (tokens added per turn) *before* you install. A skill you'll only ever trigger yourself? `disable-model-invocation: true` keeps its cost at zero until you call it.

- **The `description` is the trigger.** Make it specific and slightly pushy — list the phrases that should fire it. The model tends to *under*-trigger skills.
- **Keep `SKILL.md` under ~500 lines**; push detail into a `references/` file it reads only when needed.
- **Best candidates:** anything with a fixed sequence of steps, org conventions, or "the boring bit."
- **You don't have to build these from scratch.** Whole AI-native SDD kits already exist — e.g. [spec-kit](https://github.com/github/spec-kit) and [specs.md](https://specs.md/) — collections of ready-made skills and agents, usually agnostic to the model or coding tool. We're hand-rolling one here to see how it works; in real life you'd often start from one of those.

## 🎁 Bonus — go further

- **Try the built-in skills — no install.** `/simplify` does a focused cleanup pass over code you just wrote (removes duplication, flattens nested conditionals, clarifies logic) *without changing behaviour* — the pass Anthropic's own team uses. `/security-review` scans your working changes for vulnerabilities and suggests fixes. Both ship with Claude Code — run them on some messy code.
- **Install one from the marketplace, don't reinvent it.** For what isn't built in, add the official marketplace and install a real plugin — e.g. `commit-commands` (git commit / PR workflows): `/plugin marketplace add anthropics/claude-plugins-official` → `/plugin install commit-commands@claude-plugins-official` → `/reload-plugins`. Browse the rest with `/plugin` (Discover tab) — each lists its **context cost** before you install.
- **Add an `argument-hint`** to `/specify` so it shows usage as you type it.

---

← Previous: [Exercise 1 — Spec-driven](./1-spec-brownfield.md)  ·  Next: [Exercise 3 — TDD →](./3-tdd-brownfield.md)
