`Greenfield track · Exercise 2 of 8` — [Welcome](../README.md)

# Exercise 2 — Write the spec before you build (greenfield)

**Track:** Greenfield · **Time:** ~30 min
**Builds on:** your `docs/brief.md` and running skeleton from Exercise 1. · **Adds to your build:** a reusable spec template, your first feature spec, and the first real feature on top of the skeleton.

> **Why it matters:** when Copilot can build almost anything in minutes, the expensive mistake shifts — it's no longer slow code, it's *the wrong thing, built well.* A short spec, agreed **before** any code, is the cheapest way to stay aimed at what you meant. On day one you wrote a *brief* — the whole product at a glance. Now you'll **spec a single slice of it** properly and build that slice.

> **⏱️ Keep the slice small.** The ~30 min covers the template, the spec, your edit, *and* the build. Pick a slice that's small but meaningful — genuinely useful on its own, not the most ambitious thing in your brief. If you'd rather spec something bigger or more complex, that's fine — just expect to run past 30 min, and pick up the build in your own time while the room moves on to Exercise 3.

> **Note — this isn't a spec-driven-development (SDD) lab.** We're not following a formal SDD framework here; the goal is just to *feel* the value of a spec agreed before code. If you want to go deeper, there are mature AI-native SDD toolkits — e.g. [spec-kit](https://github.com/github/spec-kit) (GitHub's own, with first-class Copilot support) and [specs.md](https://specs.md/) — that wrap this into a full framework of skills and agents, usually agnostic to the model or coding tool. We're keeping it simple on purpose.

---

## Why this exercise

Your brief says *what the product is*. A spec says *how one feature behaves* — concretely enough to build and check. You'll set up a reusable template, let Copilot help you pick the first slice and interview you to spec it, edit it until it's right, then build it. The magic is the interview drawing the detail out of you, and *you* editing the result — not Copilot writing the first draft.

## Before you start

- Exercise 1 done: `docs/brief.md`, a running skeleton, and `docs/adr/0001-initial-stack.md` in place.
- A rough sense of which slices of your MVP might be the first thing to build (Copilot will help you choose). **Keep it small but meaningful** — this is a 30-min slot for template + spec + build, so pick a slice you can actually finish in it.

## Steps

**1. Build a reusable spec template.** Paste this, check the sections make sense, trim anything you'd never fill in, then let Copilot save it.

```text
Before we spec anything, let's set up a reusable template. Propose a specs/_template.md:
a short, reusable spec skeleton with clear sections for context, the behaviour/requirements,
edge cases, out-of-scope, and acceptance criteria that are concrete and testable. Keep it
lean — a page, not a form nobody fills in. Show it to me and STOP; I'll check it makes sense
before we save it.
```

**2. Pick a slice and spec it.** Copilot suggests a few candidate first features, you pick one, and it **interviews you one question at a time** to fill every section of the template — then stops.

```text
Read docs/brief.md and docs/adr/0001-initial-stack.md. Suggest a few candidate first
features — the smallest slices of the MVP that are genuinely useful on their own — and
recommend one, with a sentence on why. Once I pick, interview me one question at a time —
wait for each answer — to fill every section of specs/_template.md for just that slice:
the behaviour, the edge cases, what's explicitly out of scope, and testable acceptance
criteria. Respect the out-of-scope list in the brief and hold it to one slice. Don't assume;
ask me. When you've got enough, draft specs/<feature>.md from my answers and STOP for my
review — I'll edit it before any code.
```

**3. Edit the spec.** Pin the behaviour, edge cases, and testable acceptance criteria. Hold it to *one* slice. This is where the value is.

**4. Then implement it — in plan mode.** Once the spec is right, **switch to plan mode** — press `Shift`+`Tab` to cycle into it, or type the request with the slash command:

```text
/plan Implement specs/<feature>.md
```

In plan mode Copilot can read and explore but is **blocked from editing your project files** — that's enforced by the CLI, not just requested. **Review the plan it proposes, edit it if needed, and approve it** — approving exits plan mode and lets it build. Driving that step is part of the exercise.

**5. Lock the spec-first workflow in as a rule.** So this isn't something you have to remember every time, capture it in your always-loaded instructions:

```text
Add a short "Workflow" section to .github/copilot-instructions.md with this rule:
"IMPORTANT: for any non-trivial feature, propose a spec in specs/ and STOP for my approval
before writing any implementation." Keep it to that one line plus a pointer to
specs/_template.md. Show me the file and stop.
```

Then `/clear` so the updated instructions load. Now every future feature starts spec-first by default — enforced, not remembered.

> **Why in `copilot-instructions.md`, not an `.instructions.md` file?** Path-scoped instruction files attach when Copilot works with a matching file — but "stop before implementing" has to apply *before* any file is touched. Rules that gate the very first move belong in the root file.

## What good looks like

- **`specs/_template.md`** and your **first `specs/<feature>.md`**, visibly edited by you.
- **A working first feature** on top of your skeleton — your project now *does* something.
- The scope stayed to one slice; the rest of the MVP is still on the to-do list, deliberately.

## Tips & watch-outs

> **💰 Token-smart:** the cheapest tokens you'll spend all day are the ones *before* the code — ten minutes shaping a spec saves an hour of build-it-wrong-then-fix-it rework.

- **Guard against over-scoping.** Greenfield energy wants to spec the whole app — hold it to one slice from the brief.
- **The value is your editing**, not the draft. Don't rubber-stamp.
- **Keep acceptance criteria testable** — they become real tests in Exercise 4.
- **First appearance of `specs/`** — the word "spec" starts here; your day-one file stays the *brief*.
- **Point at files with `@`.** Typing `@specs/` in the prompt box autocompletes paths and attaches the file's contents to that prompt — handy when you want Copilot looking at exactly one spec.

## 🎁 Bonus — go further

- **Try the anti-demo.** On a scratch branch, ask Copilot to build the slice with no spec, and compare to your spec'd version — the gap is the value, made visible.
- **Tighten your spec prompt.** Before you spec the next slice, tweak the step-2 prompt so Copilot asks sharper questions or produces a tighter, more testable spec. (`/refine` will tidy a roughly written prompt for you to review.)
- **Break your brief into a backlog — in GitHub Issues.** Copilot CLI ships with the **GitHub MCP server** already connected, so there's nothing to install: ask it to create an issue per slice of your brief, then later *"draft a spec from issue #12."* It reads and writes issues directly. No GitHub remote? A `docs/features/` folder of `[xx]-[feature].md` files is a fine offline stand-in. (Jira works too, via an Atlassian MCP server added with `/mcp add` — but that's heavier to set up; reach for the built-in GitHub tools first, and leave yourself time to finish the whole loop.)

---

← Previous: [Exercise 1 — Project setup](./1-context-greenfield.md)  ·  Next: [Exercise 3 — Skills →](./3-skills-greenfield.md)
