`Brownfield track · Exercise 1 of 8` — [Welcome](./README.md)

# Exercise 1 — Write the spec before you build (brownfield)

**Track:** Brownfield · **Time:** ~30 min
**Builds on:** the context files from Exercise 0. · **Adds to your build:** a reusable spec template, your first written spec, and a real task implemented from it.

> **Why it matters:** when Claude can build almost anything in minutes, the expensive mistake shifts — it's no longer slow code, it's *the wrong thing, built well.* A short spec, agreed **before** any code, is the cheapest way to keep Claude aimed at what you actually meant: it moves the thinking upstream, where changing your mind is still free. The spec is the contract; the code is just one implementation of it.

> **Note — this isn't a spec-driven-development (SDD) lab.** We're not following a formal SDD framework here; the goal is just to *feel* the value of a spec agreed before code. If you want to go deeper, there are mature AI-native SDD toolkits — e.g. [spec-kit](https://github.com/github/spec-kit) and [specs.md](https://specs.md/) — that wrap this into a full framework of skills and agents, usually agnostic to the model or coding tool. We're keeping it simple on purpose.

---

## Why this exercise

You're going to resist the urge to say "build X" and instead pin the *what* down first — a reusable template, then a spec for one real task — and only then implement. The magic isn't Claude writing the spec; it's the interview that draws the detail out of you, and *you* editing the result. Ten minutes shaping a spec saves an hour of rework on code that missed the point.

## Before you start

- Exercise 0 done (Claude has your context and can read your ADRs).
- One of the real tasks you brought — a feature, a bug, or a focused change.

## Steps

**1. Build a reusable spec template.** Paste this, check the sections fit how your team works, trim anything you'd never fill in, then let Claude save it.

```text
Before we write any spec, let's set up a reusable template. Look at how this repo already
describes work — issues, tickets, PR descriptions, any existing docs — and propose a
specs/_template.md: a short, reusable spec skeleton with clear sections for context, the
behaviour/requirements, edge cases, out-of-scope, and acceptance criteria that are concrete
and testable. Keep it lean — a page, not a form nobody fills in. Show it to me and STOP;
I'll check it makes sense before we save it.
```

**2. Spec one real task.** Tell Claude which task; it reads the code and your ADRs, then **interviews you one question at a time** to fill every section of the template, and stops.

```text
Now let's spec one real task. I'll tell you which one. First read the code it touches so
the spec reflects reality, and read docs/adr/ so it respects decisions already made. Then
interview me one question at a time — wait for each answer — to fill every section of
specs/_template.md: the behaviour I want, the edge cases, what's explicitly out of scope,
and acceptance criteria concrete enough to test. Don't assume and don't fill gaps yourself;
ask me. When you've got enough, draft specs/<feature>.md from my answers and STOP for my
review — I'll edit it before any code.
```

**3. Edit the spec.** Pin down the behaviour, the edge cases, and the acceptance criteria. This is where the value is.

**4. Then implement it yourself.** Once the spec is right, tell Claude to build it (Plan Mode is your call). Driving that step is part of the exercise.

## What good looks like

- **`specs/_template.md`** and **`specs/<your-feature>.md`** — the second one visibly edited by you, not a rubber-stamped first draft.
- **The task actually implemented**, and matching the acceptance criteria you wrote.
- A felt difference: less back-and-forth, less "that's not what I meant."

## Tips & watch-outs

- **The value is your editing.** If you approve the first draft unchanged, you've just laundered a guess into a document.
- **Keep specs concise.** Capture the detail that matters — but if a spec gets long or complicated, that's the signal to split it into smaller slices.
- **Keep acceptance criteria testable** — you'll turn them into real tests in Exercise 3.
- **Don't over-spec** a one-line fix. Spec the risky, ambiguous work.

## 🎁 Bonus — go further

- **Try the anti-demo.** On a scratch branch, ask Claude to build the feature with *no* spec. Compare what it invents to what your spec pinned down — the gap is the value, made visible.
- **Wire the workflow as a rule.** Add a tiny `.claude/rules/workflow.md`: "for any non-trivial feature, propose a spec and STOP for approval before writing code." Now the habit is enforced, not remembered.
- **Spec a second, independent task** now, using the same two-step flow.

---

← Previous: [Exercise 0 — Context setup](./0-context-brownfield.md)  ·  Next: [Exercise 2 — Skills →](./2-skills-brownfield.md)
