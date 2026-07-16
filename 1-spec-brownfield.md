`Brownfield track · Exercise 1 of 8` — [Overview & index](./README.md)

# Exercise 1 — Write the spec before you build (brownfield)

**Track:** Brownfield · **Time:** ~30 min
**Builds on:** the context files from Exercise 0. · **Adds to your build:** your first written spec, and a real task implemented from it.

> **Why it matters:** the classic failure of agentic coding is *"Claude built the wrong thing, fast."* A short spec, agreed **before** any code, is the cheapest fix there is — it moves the thinking upstream where changes are free. The spec is the contract; the code is just one implementation of it.

---

## Why this exercise

You're going to resist the urge to say "build X" and instead have Claude write a **short spec** first — then you edit it until it's actually right, and only then implement. The magic isn't Claude writing the spec; it's *you* editing it. Ten minutes shaping a spec saves an hour of rework on code that missed the point.

## Before you start

- Exercise 0 done (Claude has your context and can read your ADRs).
- One of the real tasks you brought — a feature, a bug, or a focused change.

## What you'll do

1. Paste the prompt below to have Claude draft a spec into `specs/` — reading the relevant code and your ADRs first, so it reflects reality.
2. **Edit the spec.** Pin down the behaviour, the edge cases, and the acceptance criteria. This is the whole exercise.
3. Enter **Plan Mode** (`shift+tab`), have Claude plan against the approved spec, approve, and let it implement.

## The prompt

Copy this into Claude as-is:

```text
Take one of the tasks I brought. Don't build it yet. First read the code it touches
so the spec reflects reality, and read docs/adr/ so it respects decisions already made.
Then draft a spec into specs/<feature>.md using specs/_template.md (create the template
if it doesn't exist). Fill every section; make the acceptance criteria concrete and
testable. STOP for my review — I'll edit it before any code.

Once I've edited and approved it: enter Plan Mode, produce an implementation plan
against the approved spec, and only implement after I approve the plan.
```

## What good looks like

- **`specs/_template.md`** and **`specs/<your-feature>.md`** — the second one visibly edited by you, not a rubber-stamped first draft.
- **The task actually implemented**, and matching the acceptance criteria you wrote.
- A felt difference: less back-and-forth, less "that's not what I meant."

## Tips & watch-outs

- **The value is your editing.** If you approve the first draft unchanged, you've just laundered a guess into a document.
- **Keep specs to a page.** A spec that takes longer than the code defeats the purpose.
- **Keep acceptance criteria testable** — you'll turn them into real tests in Exercise 3.
- **Don't over-spec** a one-line fix. Spec the risky, ambiguous work.

## 🎁 Bonus — go further

- **Try the anti-demo.** On a scratch branch, ask Claude to build the feature with *no* spec. Compare what it invents to what your spec pinned down — the gap is the value, made visible.
- **Spec a second, independent task** now. You'll want two independent slices for the parallel-Claude exercise (5).
- **Wire the workflow as a rule.** Add a tiny `.claude/rules/workflow.md`: "for any non-trivial feature, propose a spec and STOP for approval before writing code." Now the habit is enforced, not remembered.

---

← Previous: [Exercise 0 — Context setup](./0-context-brownfield.md)  ·  Next: [Exercise 2 — Skills →](./2-skills-brownfield.md)
