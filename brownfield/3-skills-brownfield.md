`Brownfield track · Exercise 3 of 8` — [Welcome](../README.md)

# Exercise 3 — Turn your workflow into a skill (brownfield)

**Track:** Brownfield · **Time:** ~25 min
**Builds on:** the spec-drafting you did by hand in Exercise 2. · **Adds to your build:** a reusable `/specify` skill — and a spec ready to build in Exercise 4.

> **Why it matters:** a skill captures *the way you do X here* once, so it persists across sessions and teammates — and fires automatically when a task matches. In Exercise 2 you typed a paragraph to make Copilot draft a spec. You'll type it again every feature… unless you capture it.

---

## Why this exercise

You'll turn last exercise's repetitive spec-drafting prompt into a one-keystroke `/specify` skill. The point isn't "what is a skill" (you've seen that) — it's capturing *your* real, repeated work so the loop gets faster every pass.

Copilot CLI uses the open **Agent Skills** format: a folder with a `SKILL.md` (YAML frontmatter + instructions), plus any scripts or reference files it needs. Project skills live in `.github/skills/<name>/` (committed, so your team gets them); personal ones in `~/.copilot/skills/<name>/`.

## Before you start

- Exercise 2 done — you've got a `specs/_template.md` and a spec-drafting flow fresh in mind.

## Steps

**1. Build the `/specify` skill.** Capture your spec-drafting workflow as a reusable, self-contained skill — the prompt spells out every step so it works even in a fresh session with no prior context.

```text
Create a skill at .github/skills/specify/SKILL.md that drafts a feature spec for this
repo. It must be self-contained — assume a fresh session with no prior conversation.
Frontmatter: name: specify; a specific description that lists trigger phrases ("write a
spec", "spec this feature", "specify ..."); and argument-hint: <feature>. Body — the
steps to run when invoked: (1) read the code the feature touches and docs/adr/ so the
spec reflects reality and respects past decisions; (2) open specs/_template.md, creating
a lean one if it's missing; (3) fill every section, asking me one question at a time for
anything you can't confidently infer; (4) write the result to specs/<kebab-feature>.md;
(5) STOP for review — do NOT write any implementation. Show me the finished SKILL.md and
stop.
```

Then load it without restarting, and check it registered:

```text
/skills reload
```

```text
/skills info specify
```

**2. Pick the model for spec work.** Spec quality is worth the strongest model — but unlike agents, **Copilot CLI skills can't pin a model or effort** in their frontmatter; a skill runs on whatever your session is using. So make the switch yourself: open **`/model`**, choose an **Opus-class** model at **high** effort (if your plan doesn't include one, stay on Sonnet at high), run the skill, then switch back. It's one extra step — and a useful habit: *you* decide which steps deserve the expensive model. (Want it pinned in config instead? See the 🎁 Bonus.)

**3. Trigger it two ways.** Run it explicitly with `/specify <feature>`, and also **describe the task in plain language** — without naming the skill — to confirm its `description` fires it on its own.

**4. Spec the task you'll build next.** Use your new `/specify` to draft a spec for a **small, testable task** you'll implement test-first in Exercise 4. Edit it until the acceptance criteria are concrete. You'll walk into the next exercise with a spec in hand.

## What good looks like

- **`/specify <feature>`** does in one keystroke what took a paragraph last exercise.
- It **fires when you describe its task** in plain language, not only when you type `/specify`.
- **A spec ready for Exercise 4**, with testable acceptance criteria.

## Tips & watch-outs

> **💰 Token-smart:** skills load *progressively* — a skill's name and description sit in context every turn so Copilot knows it's there, but the full instructions load only when it fires. Keep descriptions tight. For a skill you'll only ever trigger yourself, `disable-model-invocation: true` stops Copilot reaching for it on its own — you call it by name with `/specify`.

- **The `description` is the trigger.** Make it specific and slightly pushy (max 1024 characters) — list the phrases that should fire it. Models tend to *under*-trigger skills.
- **Keep `SKILL.md` under ~500 lines**; push detail into a `references/` file in the skill's folder that it reads only when needed — every file in the skill directory is available to it.
- **Skills run in your session; agents run in their own.** That's why a skill can interview you one question at a time — and why it inherits your session's model.
- **You don't have to build these from scratch.** Whole AI-native SDD kits already exist — e.g. [spec-kit](https://github.com/github/spec-kit) and [specs.md](https://specs.md/) — collections of ready-made skills and agents, usually agnostic to the model or coding tool. There's also a community catalogue at [awesome-copilot](https://awesome-copilot.github.com/skills/) you can install from with `/skills add <URL>`. We're hand-rolling one here to see how it works; in real life you'd often start from one of those.

## 🎁 Bonus — go further

- **Try the built-in reviewers — no install.** `/security-review` scans your current changes for vulnerabilities and suggests fixes; `/rubber-duck` gets a critique of a plan or piece of code from a complementary model. Both ship with Copilot CLI — run them on some messy code. There's no bundled "simplify" command, so build one: a skill that does a focused cleanup pass over code you just changed (removes duplication, flattens nested conditionals, clarifies logic) *without changing behaviour*, then runs the tests to prove it.
- **Pin the model with an agent instead.** Custom agents *can* set `model:` and `reasoningEffort:` in their frontmatter. Create `.github/agents/spec-writer.agent.md` with the same steps as your skill plus `model:` set to an Opus-class model and `reasoningEffort: high`, restart (`/restart`), then select it with `/agent` when you sit down to spec. Selecting it with `/agent` makes it your *session* agent, so it can still interview you. Compare: is the auto-pinned model worth an extra file to maintain?
- **Tune your skill's frontmatter.** `argument-hint` shows `/specify`'s usage as you type it; try `disable-model-invocation: true` on a skill you only ever call yourself, and `allowed-tools` to pre-approve the tools it needs so it doesn't stop for permission.
- **Capture a skill for your own repeated work.** If there's a task you do the *exact* same way every time — scaffolding a component, a migration, a PR write-up — capture it as a skill the same way you built `/specify` (you know the shape now — no prompt needed). If nothing in your repo is genuinely repetitive, skip this; don't build a skill for its own sake.

---

← Previous: [Exercise 2 — Spec-driven](./2-spec-brownfield.md)  ·  Next: [Exercise 4 — TDD →](./4-tdd-brownfield.md)
