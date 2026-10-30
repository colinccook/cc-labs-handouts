`Multirepo track · Exercise 2 of 8` — [Welcome](../README.md)

# Exercise 2 — Write the cross-service spec before you build (multirepo)

**Track:** Multirepo · **Time:** ~35 min
**Builds on:** the journey workspace and map from Exercise 1. · **Adds to your build:** a reusable *cross-service* spec template, your first written spec, and a real change implemented from it.

> **Why it matters:** when Claude can build almost anything in minutes, the expensive mistake shifts — it's no longer slow code, it's *the wrong thing, built well.* In a microservices journey the wrong thing is usually **the right change in the wrong service**, or a change that's correct locally and breaks a consumer two hops away. A short spec that names *every* service touched and *every* contract that moves, agreed **before** any code, is the cheapest way to catch that — it moves the thinking upstream, where changing your mind is still free.

> **⏱️ Keep the task small.** The ~35 min covers the template, the spec, your edit, *and* the build. Pick a change that touches **one or two services** — a new field carried through an event, a validation rule, a notification tweak — not a journey redesign. If you'd rather spec something bigger, that's fine, just expect to run over and pick up the build in your own time.

> **Note — this isn't a spec-driven-development (SDD) lab.** We're not following a formal SDD framework; the goal is to *feel* the value of a spec agreed before code. If you want to go deeper, there are mature AI-native SDD toolkits — e.g. [spec-kit](https://github.com/github/spec-kit) and [specs.md](https://specs.md/). We're keeping it simple on purpose.

---

## Why this exercise

You'll resist the urge to say "add X to the order flow" and instead pin the *what* down first — a reusable template, then a spec for one real change — and only then implement. The spec's job in this track is to make the **blast radius** explicit: which repos change, which contracts change, which consumers must keep working, and how you'll know it works in dev. The magic isn't Claude writing the spec; it's the interview that draws the detail out of you, and *you* editing the result.

## Before you start

- Exercise 1 done (Claude has the journey map, the contracts rule and your ADRs).
- One real change you brought that touches the journey. **Small but meaningful** — one or two services.

## Steps

**1. Build a reusable cross-service spec template.** Paste this, check the sections fit how your team works, trim anything you'd never fill in, then let Claude save it.

```text
Before we write any spec, let's set up a reusable template for changes that span services.
Look at how my team already describes work — issues, tickets, PR descriptions in the service
repos, docs/journey/ — and propose specs/_template.md: a short, reusable skeleton with clear
sections for:
- context and the journey step(s) affected;
- the behaviour/requirements;
- services touched — a table: service · what changes · PR needed (y/n);
- contracts touched — events, messages, APIs, shared packages that change, whether the change
  is additive/breaking, and every consumer in this workspace (and known consumers outside it);
- rollout order and compatibility — which service deploys first, dual-publish or feature flag
  if needed;
- edge cases, including retries, duplicates, out-of-order and partial failure;
- out-of-scope;
- acceptance criteria that are concrete and testable, split into (a) criteria provable with a
  fast local test in one service and (b) criteria that need the dev-environment test project.
Keep it lean — a page, not a form nobody fills in. Show it to me and STOP; I'll check it
before we save it.
```

**2. Spec one real change.** Tell Claude which change; it reads the code in *every* affected service, the journey map, and your ADRs, then **interviews you one question at a time** and stops.

```text
Now let's spec one real change. I'll tell you which one. First read docs/journey/, the
contracts rule, and docs/adr/, then read the code in EVERY service this change could touch —
including consumers of any event or API that changes — so the spec reflects reality and
respects decisions already made. Then interview me one question at a time — wait for each
answer — to fill every section of specs/_template.md. Be especially rigorous on: which
services change, which contracts move and whether that's breaking, who consumes them,
rollout order, and which acceptance criteria can be proven locally vs only against dev.
Don't assume and don't fill gaps yourself; ask me. When you've got enough, draft
specs/<change>.md from my answers and STOP for my review — I'll edit it before any code.
```

**3. Edit the spec.** Pin down the services-touched table, the contract changes, the rollout order, and the acceptance criteria. If the table shows four services for a "small" change — good, you've just learnt something before writing code. Consider splitting it.

**4. Then implement it — in Plan Mode.** Once the spec is right, **switch to Plan Mode** (`shift`+`tab`) and tell Claude to implement the spec. The plan should be **ordered by rollout** — the consumer-safe change first, the publisher change second — and should name which repo each step edits. **Review the plan, edit it, approve it** — then let it build. Driving that step is part of the exercise.

**5. Lock the spec-first workflow in as a rule.** So this isn't something you have to remember every time:

```text
Create .claude/rules/workflow.md with an always-on rule: "IMPORTANT: for any change that
touches more than one service, or any change to a published contract/event/API, propose a
spec in specs/ using specs/_template.md and STOP for my approval before writing any
implementation. Single-service, non-contract fixes can skip the spec." Then add a one-line
pointer to it from the root CLAUDE.md so it's discoverable. Show me both files and stop.
```

Now every cross-service change starts spec-first by default — enforced, not remembered.

## What good looks like

- **`specs/_template.md`** with the services-touched and contracts-touched tables, and **`specs/<your-change>.md`** — visibly edited by you.
- **The change actually implemented** across the affected repos, in rollout order, matching the acceptance criteria you wrote.
- A felt difference: you knew the blast radius *before* writing code, not when a consumer broke in dev.

## Tips & watch-outs

> **💰 Token-smart:** the cheapest tokens you'll spend all day are the ones *before* the code. In a multi-repo change, a missed consumer costs a whole extra build-test-deploy cycle against dev — the spec's consumer list is where that gets caught for pennies.

- **The value is your editing.** If you approve the first draft unchanged, you've just laundered a guess into a document.
- **The services-touched table is the spec's heart.** If Claude can't fill it confidently, it didn't read enough — send it back.
- **Additive beats breaking, every time.** Add a field, add a new event version, add an endpoint — and let consumers migrate. If the spec says "breaking", it should also say "why not additive?"
- **Split acceptance criteria by where they run.** Local-provable criteria drive the fast TDD loop in Exercise 4; dev-environment criteria drive the slow outer loop. Mixing them up is how "the tests pass" stops meaning anything.
- **Don't over-spec** a one-service, non-contract fix. Spec the risky, cross-cutting work.

## 🎁 Bonus — go further

- **Try the anti-demo.** On scratch branches, ask Claude to make the change with *no* spec. Count the services it forgot and the consumers it didn't check — the gap is the value, made visible.
- **Spec from a GitHub issue.** If your backlog lives in GitHub Issues and you've authenticated `gh`, try: *"read issue #123 in <org>/<repo> with gh and draft a spec from it."* The spec's services table will usually be longer than the issue implied.
- **Tighten your spec prompt.** Spec a second change — but first tweak the step-2 prompt. What question would have caught the consumer Claude missed? Add it. The prompt is a tool you can sharpen.

---

← Previous: [Exercise 1 — Context setup](./1-context-multirepo.md)  ·  Next: [Exercise 3 — Skills →](./3-skills-multirepo.md)
