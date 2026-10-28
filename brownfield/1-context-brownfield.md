`Brownfield track · Exercise 1 of 8` — [Welcome](../README.md)

# Exercise 1 — Set up your repo's context (brownfield)

**Track:** Brownfield — you brought a repo you already work in.
**Time:** ~30 min · **You'll leave with:** a thin `.github/copilot-instructions.md`, a set of `.github/instructions/`, and at least one decision captured as an ADR.

> **The bigger picture:** these exercises aren't about *trying out* Copilot CLI — they're about turning it into a permanent part of how you ship. Each one leaves a real improvement in your repo, and by the end of day 2 you'll have a repeatable spec → build → test → review loop running on your own code, making you measurably faster. This first exercise gives Copilot the context to stop guessing about your project.

> **Default model & effort:** unless a step says otherwise, run on **Claude Sonnet** (the Copilot CLI default) at **high reasoning effort** — set both in **`/model`**, or launch with `copilot --effort high`. That's the recommended default across these exercises. Try other models and effort levels as you go; the right choice depends on the task (Exercise 6's cheap Haiku reviewer is the one deliberate exception). Save top-tier, high-multiplier models (Opus-class) for when a step asks for them — `/model` shows each model's cost, `/usage` shows what you've spent.

---

## Why this exercise

Copilot is only as good as the context it carries into each message — your commands, your conventions, and the *why* behind decisions already baked into your codebase. Most repos give it none of that, so it re-derives (and sometimes fights) your architecture every session. The fix isn't a giant instructions file — it's a **thin one that points at what you already have**, plus a few focused instruction files that load only when relevant.

> **One idea to hold onto:** your `.github/copilot-instructions.md` is a *table of contents, not an encyclopedia*. If it's already written down (README, docs, ADRs), link to it — don't copy it in, or you'll maintain it twice and Copilot will get the stale copy.

### How Copilot CLI loads context

| File | When it loads | Use it for |
|---|---|---|
| `.github/copilot-instructions.md` | Every message, in every session in this repo | The thin table of contents: commands, a handful of always-true rules, pointers |
| `.github/instructions/<name>.instructions.md` with `applyTo: "<glob>"` | When Copilot reads or edits a file matching the glob (`"**"` = any file) | Focused rule sets — conventions, architecture, one area of the code (api, ui, db) |
| `AGENTS.md` in a subfolder | When Copilot works in or below that folder | Context for one subproject of a monorepo |
| `~/.copilot/copilot-instructions.md` | Every session, every repo | *Your* personal preferences — not the team's |

> **Already have a `CLAUDE.md`, `AGENTS.md`, or `.claude/rules/`?** Copilot CLI reads those too. Great for a head start — but if you add `.github/copilot-instructions.md` alongside them, the same rules load twice. Decide on one home (this workshop uses `.github/`) and fold the rest into it, or keep `AGENTS.md` as your single root file if your team uses several agents. Run `/instructions` to see exactly which files are loading.

## Before you start

- Your repo open, building and running, with `copilot` running inside it.
- A rough sense of your commands (run, test, lint) and where your docs live.

## Steps

**1. Start with `/init`.** Run it — Copilot scans the repo and generates a starter `.github/copilot-instructions.md` (build/test/lint commands, high-level architecture, conventions it can infer). If the file already exists, it suggests improvements you can accept or reject. This is the recommended starting point; don't hand-write from a blank page.

```text
/init
```

**2. Take it to a proper, modular setup.** `/init` gives you one file — now make it best-practice. Paste this; Copilot proposes the modular structure and stops for your approval:

```text
I've just run /init, so there's a starter .github/copilot-instructions.md in the repo.
Take it to a proper, lean, modular setup — don't just leave one big file.

First inventory the docs I already have (README, docs/, any ADRs, CONTRIBUTING, and any
existing CLAUDE.md / AGENTS.md / .claude/rules) — the instructions should point at
those, not duplicate them. Then propose:

1. A thin .github/copilot-instructions.md (aim under ~40 lines): the key commands, ~5
   always-true rules, and a "where the detail lives" section linking my existing docs by
   plain path (not @-imports, which inline the whole file). Trim anything /init added
   that you could just read from the code.
2. .github/instructions/ splitting concerns: a conventions.instructions.md with
   applyTo: "**", plus one or more narrowly scoped files (loaded only when I touch that
   area, e.g. api, ui, db) with the right applyTo globs.
3. If I have ADRs, a small architecture.instructions.md (applyTo: "**") pointing at
   docs/adr/.
4. If this is a large repo or monorepo, tell me whether a nested AGENTS.md inside a
   subproject would help — context that loads only when I work in that area — and where
   you'd put it.
5. If I already have CLAUDE.md / AGENTS.md / .claude/rules, tell me what would end up
   loaded twice and how you'd consolidate.

Show me the proposed file tree and each file's contents, and STOP for my approval
before creating or changing anything.
```

**3. Review and create.** Read the proposal. Trim anything bloated, fix anything wrong, then let it create the files.

**4. Capture architecture decisions as ADRs — Copilot suggests, you approve.** The point is that Copilot knows the *why* behind your architecture and can defend it later. Paste this:

```text
Help me capture architecture decisions as ADRs. First review the codebase (and any
existing docs/adr/) and SUGGEST two or three decisions or conventions that aren't written
down yet — e.g. the stack choice, a layering rule, a data-access pattern. Don't write
anything yet: show me the candidates and wait for me to pick.

Then, for the one(s) I approve, write each to docs/adr/NNNN-<slug>.md in a short standard
ADR format (context, decision, consequences). Finally, create or update
.github/instructions/architecture.instructions.md (applyTo: "**") so it points at
docs/adr/ as the home for these decisions AND says when a new ADR is required — breaking
changes, and decisions that are costly to reverse. Make sure copilot-instructions.md
references it. Show me everything and stop.
```

Review its suggestions before it writes anything — you're the one who knows which decisions actually matter.

**5. Load your new context.** Instruction files are read when a session starts, so edits aren't picked up mid-conversation. Run `/clear` (or `/new`) for a fresh conversation, then `/instructions` to confirm every file you expect is listed and enabled.

## What good looks like

By the end you should have, and be able to point at:

- **A thin `.github/copilot-instructions.md`** that *routes* to your docs instead of restating them.
- **`.github/instructions/`** with a couple of `applyTo: "**"` files and at least one narrowly scoped file that only loads when Copilot touches that area.
- **At least one ADR** (`docs/adr/`) capturing a real decision that used to live only in someone's head — plus the tiny architecture instructions file pointing at it.

## Tips & watch-outs

> **💰 Token-smart:** `copilot-instructions.md` and your `applyTo: "**"` files ride along with *every* message — bloat here is a tax you pay all day. It's a balancing act: too little and Copilot guesses, too much and the rules that matter get lost in the noise. Keep it a table of contents, not an encyclopedia. Run `/context` after your setup to see what's in the window; trim, `/clear` so the new version loads, run `/context` again, and watch that number drop.

- **Know your controls.** `/model` switches model *and* reasoning effort (`low` → `max`, depending on the model). There's no `ultrathink`-style keyword in Copilot CLI — for a one-off deeper pass, raise the effort in `/model` for that step and drop it back, or ask `/rubber-duck` for a critique from a complementary model. You'll pick models per step as you go — a stronger model for specs, Haiku for the cheap review later.
- **Don't over-split.** 3–4 instruction files beat 15. If a rule is short and universal, leave it in `copilot-instructions.md`.
- **`applyTo` globs are the skill.** Too broad (`src/**`) and it's always-on in disguise; too narrow and it never fires. Separate several patterns with commas: `applyTo: "src/api/**/*.ts,src/api/**/*.tsx"`.
- **`applyTo: "**"` isn't quite "always".** Path-specific instructions attach when Copilot works with a matching file. A rule that must hold *before* any file is touched belongs in `copilot-instructions.md` itself.
- **The captured *why* is the payoff.** Your instructions *and* ADRs together — not any one file — are what stop Copilot from helpfully undoing a deliberate decision later.
- **Read before you approve.** Catch a wrong assumption while it's still free to fix.

## 🎁 Bonus — go further

Done early, or want to push it? Try any of these:

- **Prove the ADR guardrail works.** Ask Copilot to make a change that quietly contradicts the decision you just captured. With the architecture instructions in place it should *push back* and cite the ADR rather than just doing it. If it doesn't, strengthen the rule with a `YOU MUST` / `IMPORTANT` directive, `/clear`, and try again — watch how much harder the model leans on the emphatic phrasing. That pushback is the whole point.
- **Bonus for Copilot users across GitHub:** the same `.github/copilot-instructions.md` and `.github/instructions/` files are read by Copilot code review on your PRs and by Copilot cloud agent — one set of rules, every surface. (Add `excludeAgent: "code-review"` to an instructions file's frontmatter if a rule only makes sense for the coding agent.)

---

← Previous: [Welcome](../README.md)  ·  Next: [Exercise 2 — Spec-driven development →](./2-spec-brownfield.md)
