`Greenfield track · Exercise 2 of 7` — [Welcome](./README.md)

# Exercise 2 — Write the spec before you build (greenfield)

**Track:** Greenfield · **Time:** ~30 min
**Builds on:** your `docs/brief.md` and running skeleton from Exercise 1. · **Adds to your build:** a reusable spec template, your first feature spec, and the first real feature on top of the skeleton.

> **Why it matters:** when Claude can build almost anything in minutes, the expensive mistake shifts — it's no longer slow code, it's *the wrong thing, built well.* A short spec, agreed **before** any code, is the cheapest way to stay aimed at what you meant. On day one you wrote a *brief* — the whole product at a glance. Now you'll **spec a single slice of it** properly and build that slice.

> **Note — this isn't a spec-driven-development (SDD) lab.** We're not following a formal SDD framework here; the goal is just to *feel* the value of a spec agreed before code. If you want to go deeper, there are mature AI-native SDD toolkits — e.g. [spec-kit](https://github.com/github/spec-kit) and [specs.md](https://specs.md/) — that wrap this into a full framework of skills and agents, usually agnostic to the model or coding tool. We're keeping it simple on purpose.

---

## Why this exercise

Your brief says *what the product is*. A spec says *how one feature behaves* — concretely enough to build and check. You'll set up a reusable template, let Claude help you pick the first slice and interview you to spec it, edit it until it's right, then build it. The magic is the interview drawing the detail out of you, and *you* editing the result — not Claude writing the first draft.

## Before you start

- Exercise 1 done: `docs/brief.md`, a running skeleton, and `docs/adr/0001-initial-stack.md` in place.
- A rough sense of which slices of your MVP might be the first thing to build (Claude will help you choose).

## Steps

**1. Build a reusable spec template.** Paste this, check the sections make sense, trim anything you'd never fill in, then let Claude save it.

```text
Before we spec anything, let's set up a reusable template. Propose a specs/_template.md:
a short, reusable spec skeleton with clear sections for context, the behaviour/requirements,
edge cases, out-of-scope, and acceptance criteria that are concrete and testable. Keep it
lean — a page, not a form nobody fills in. Show it to me and STOP; I'll check it makes sense
before we save it.
```

**2. Pick a slice and spec it.** Claude suggests a few candidate first features, you pick one, and it **interviews you one question at a time** to fill every section of the template — then stops.

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

**4. Then implement it yourself.** Once the spec is right, tell Claude to build it (Plan Mode is your call). Driving that step is part of the exercise.

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

## 🎁 Bonus — go further

- **Try the anti-demo.** On a scratch branch, ask Claude to build the slice with no spec, and compare to your spec'd version — the gap is the value, made visible.
- **Wire the workflow as a rule.** Add `.claude/rules/workflow.md`: "for any non-trivial feature, propose a spec and STOP for approval before writing code."
- **Break your brief into a feature backlog.** Ask Claude to create a `docs/features/` folder and help you break the brief down into `[xx]-[feature].md` files — a running list of slices you can spec and implement later, one at a time.

> **Tip:** in a real project your backlog usually lives in **GitHub Issues, Jira, or similar** — and Claude can work with it there too, via the `gh` CLI or a Jira MCP server. The `docs/features/` folder is just a lightweight stand-in for the workshop.

---

← Previous: [Exercise 1 — Project setup](./1-context-greenfield.md)  ·  Next: [Exercise 3 — Skills →](./3-skills-greenfield.md)
