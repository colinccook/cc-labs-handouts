`Greenfield track · Exercise 1 of 8` — [Overview & index](./README.md)

# Exercise 1 — Write the spec before you build (greenfield)

**Track:** Greenfield · **Time:** ~30 min
**Builds on:** your `docs/brief.md` and running skeleton from Exercise 0. · **Adds to your build:** your first feature spec, and the first real feature on top of the skeleton.

> **Why it matters:** the classic failure of agentic coding is *"Claude built the wrong thing, fast."* A short spec, agreed **before** any code, is the cheapest fix there is. On day one you wrote a *brief* — the whole product at a glance. Now you'll **spec a single slice of it** properly and build that slice.

---

## Why this exercise

Your brief says *what the product is*. A spec says *how one feature behaves* — concretely enough to build and check. You'll pick the smallest genuinely-useful slice of your MVP, have Claude draft a spec, edit it until it's right, then implement. The magic is *you* editing the spec, not Claude writing it.

## Before you start

- Exercise 0 done: `docs/brief.md`, a running skeleton, and `docs/adr/0001-initial-stack.md` in place.
- A sense of which single slice of your MVP is the most sensible first thing to build.

## What you'll do

1. Paste the prompt below. Claude reads your brief and ADR, picks (with you) the first slice, and drafts a spec into `specs/` — then stops.
2. **Edit the spec.** Pin the behaviour, edge cases, and testable acceptance criteria. Hold it to *one* slice.
3. Enter **Plan Mode** (`shift+tab`), plan against the spec, approve, implement.

## The prompt

> Read `docs/brief.md` and `docs/adr/0001-initial-stack.md`. Pick the **single smallest slice of the MVP that's genuinely useful on its own** — the first real feature. **Don't build it yet.** Draft a spec for just that slice into `specs/<feature>.md` using `specs/_template.md` (create the template if it doesn't exist). Fill every section; make the acceptance criteria concrete and testable, and keep the scope to *one* slice — respect the out-of-scope list in the brief. **STOP for my review — I'll edit it before any code.**
>
> Once I've edited and approved it: enter Plan Mode, produce an implementation plan **against the approved spec** and the stack in ADR-0001, and only implement after I approve the plan.

## What good looks like

- **`specs/_template.md`** and your **first `specs/<feature>.md`**, visibly edited by you.
- **A working first feature** on top of your skeleton — your project now *does* something.
- The scope stayed to one slice; the rest of the MVP is still on the to-do list, deliberately.

## Tips & watch-outs

- **Guard against over-scoping.** Greenfield energy wants to spec the whole app — hold it to one slice from the brief.
- **The value is your editing**, not the draft. Don't rubber-stamp.
- **Keep acceptance criteria testable** — they become real tests in Exercise 3.
- **First appearance of `specs/`** — the word "spec" starts here; your day-one file stays the *brief*.

## 🎁 Bonus — go further

- **Spec a second, independent slice** now — you'll want two independent pieces for the parallel-Claude exercise (5).
- **Wire the workflow as a rule.** Add `.claude/rules/workflow.md`: "for any non-trivial feature, propose a spec and STOP for approval before writing code."
- **Try the anti-demo.** On a scratch branch, ask Claude to build the slice with no spec, and compare to your spec'd version.

## If you get stuck

If your skeleton isn't running yet, finish Exercise 0 first — this exercise needs something to build *on*. If you've fallen back to the sample app, use the brownfield version of this exercise.

---

← Previous: [Exercise 0 — Project setup](./0-context-greenfield.md)  ·  Next: [Exercise 2 — Skills →](./2-skills-greenfield.md)
