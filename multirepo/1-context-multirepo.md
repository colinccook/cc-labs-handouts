`Multirepo track · Exercise 1 of 8` — [Welcome](../README.md)

# Exercise 1 — Set up your *journey's* context (multirepo)

**Track:** Multirepo — your team owns journeys that span many microservice repos.
**Time:** ~35 min · **You'll leave with:** a *journey workspace* that holds the repos side by side, a thin root `CLAUDE.md` that describes the journey, a set of `.claude/rules/`, and at least one cross-service decision captured as an ADR.

> **The bigger picture:** these exercises aren't about *trying out* Claude Code — they're about turning it into a permanent part of how you ship. Each one leaves a real improvement in your workspace, and by the end of day 2 you'll have a repeatable spec → build → test → review loop running across *your* services. This first exercise gives Claude the one thing nobody's repo currently has: a map of the **journey**, not just the service.

> **Default model & effort:** unless a step says otherwise, run on **Sonnet** at **`/effort high`** — that's the recommended default across these exercises. Try other models and effort levels as you go; the right choice depends on the task (Exercise 6's cheap Haiku reviewer is the one deliberate exception). We don't recommend using Fable at this point, for cost and speed purposes.

---

## Why this exercise

In a single repo, `CLAUDE.md` tells Claude *how this codebase works*. In a microservices estate the hard knowledge isn't inside any one repo — it's **between** them: which service owns which step of the journey, which events flow where, what the contracts are, and what breaks two hops downstream when you change something. Today that lives in people's heads and in a dozen half-stale wikis. Claude re-derives it every session, wrongly.

The fix is a **journey workspace**: an ordinary folder (optionally its own small git repo) with the relevant service repos cloned side by side and a thin `CLAUDE.md` at the root that routes Claude to the right service, the right contract, and the right docs. Launch `claude` *there*, and it can reach every repo in the journey at once.

> **One idea to hold onto:** the root `CLAUDE.md` is a *map of the journey*, not a copy of each service's README. Each service keeps (or gets) its own thin `CLAUDE.md`; the root one says who's who and points down.

## Before you start

- Pick **one journey** your team owns — something that spans 3–6 services. Don't start with the biggest one.
- Know roughly which repos are involved. Clone them into one parent folder, e.g.

  ```text
  ~/journeys/checkout/
  ├── order-api/
  ├── payment-service/
  ├── inventory-service/
  ├── notification-worker/
  └── checkout-e2e-tests/        ← your dotnet test project that runs against dev
  ```

- Open a terminal in the parent folder (`~/journeys/checkout/` above) and launch `claude` there. If the parent isn't a git repo, `git init` it and **`.gitignore` the service folders** — you want to version the map (`CLAUDE.md`, `.claude/`, `docs/`), not re-commit the services.

> **Prefer `git submodule` or a manifest file?** Either works. The point is that Claude can see every repo in the journey from one place. Keep it simple on the day: plain clones in one folder.

## Steps

**1. Let Claude discover the journey.** Don't hand-write the map — have Claude trace it. This is also the diagnosis work your team is already doing, so nothing here is wasted:

```text
This folder holds several microservice repos that together implement one journey my team
owns: <name the journey, e.g. "checkout — from basket to order confirmation email">. Explore
each sub-folder (read READMEs, solution/project files, message handlers, controllers, any
docs or ADRs) and work out:

1. What each service's role is in this journey, in one line each.
2. How they talk to each other — HTTP calls, published/consumed events or messages (topic
   or queue names, message types), shared databases, shared libraries/NuGet packages.
3. Where the contracts live — OpenAPI/proto files, message schema classes, shared contract
   packages — and which repo owns each one.
4. Which folder is the test project that runs against the dev environment, and how it's run.
5. Anything you're unsure about or couldn't find.

Report this as a short journey map with a sequence of steps (service → event/call → service)
and STOP. Don't create any files yet.
```

Read it carefully and **correct it** — you know the parts Claude can't see (the service that isn't in this folder, the event that's deprecated but still published). That correction is the most valuable thing you'll do this exercise.

**2. Build the modular setup from the corrected map.** Paste this; Claude proposes the structure and stops for approval:

```text
Using the corrected journey map, propose a lean, modular Claude Code setup for this
workspace — don't put everything in one big file:

1. A thin root CLAUDE.md (aim under ~50 lines): the journey in one paragraph, a table of
   services (folder · role · owner team · how to run its tests locally, if possible), the
   event/call flow as a short numbered sequence, how to run the dev-environment test
   project, ~5 always-true rules for working across these repos, and a "where the detail
   lives" section pointing at each service's own docs and the contract locations by path.
2. .claude/rules/ splitting concerns: an always-on conventions.md (eager) for things that
   apply to every service here; an always-on contracts.md that says where contracts live and
   that changing one requires checking every consumer in this workspace; and paths:-scoped
   rules (lazy) per service folder (e.g. paths: payment-service/**) holding that service's
   specific conventions.
3. For each service folder that has no CLAUDE.md of its own, a thin one (under ~25 lines):
   its commands, its conventions, and a one-line pointer back up to the root journey map.
   For services that already have one, just tell me what you'd change.
4. A docs/journey/<journey>.md holding the full journey map (the sequence, the events, the
   contracts) as a living document, with a Mermaid sequence diagram.

Show me the proposed file tree and each file's contents, and STOP for my approval before
creating or changing anything.
```

**3. Review and create.** Trim, fix, then let it create the files. The per-service `CLAUDE.md` files belong in *those* repos — they'll go up as small PRs later, which is a nice way to seed the practice across the team.

**4. Capture cross-service decisions as ADRs — Claude suggests, you approve.** The decisions that matter most in this architecture are the ones no single repo owns:

```text
Help me capture cross-service architecture decisions as ADRs. Review the journey map and the
code, then SUGGEST two or three decisions that span services and aren't written down — e.g.
the event versioning/compatibility rule, who owns a given contract, idempotency expectations
for consumers, the outbox or retry pattern in use, sync-vs-async boundaries. Don't write
anything yet: show me the candidates and wait for me to pick.

Then, for the one(s) I approve, write each to docs/adr/NNNN-<slug>.md in a short standard ADR
format (context, decision, consequences — including which services it binds). Finally,
create or update .claude/rules/architecture.md (always-on) so it points at docs/adr/ AND says
when a new ADR is required: any change to a published contract or event, any change to
how services communicate, and decisions costly to reverse. Make sure the root CLAUDE.md
references it. Show me everything and stop.
```

## What good looks like

By the end you should have, and be able to point at:

- **A journey workspace** with the services side by side and `claude` running at the root.
- **A thin root `CLAUDE.md`** that is a *map of the journey* — services, flow, contracts, how to test — and routes down to each service rather than restating it.
- **`.claude/rules/`** with always-on `conventions.md`, `contracts.md`, `architecture.md`, and at least one `paths:`-scoped per-service rule.
- **`docs/journey/<journey>.md`** with the sequence diagram — the artifact your team has been missing while diagnosing.
- **At least one cross-service ADR** capturing a decision that used to live in someone's head.

## Tips & watch-outs

> **💰 Token-smart:** with several repos in view, the always-on context can balloon fast. Keep the root `CLAUDE.md` a *map*, push service detail into `paths:`-scoped rules and the per-service `CLAUDE.md`, and run `/context` to see what you're paying every message. Nested `CLAUDE.md` files load only when Claude works in that folder — that's exactly the lazy loading you want here.

- **Start with one journey, not the estate.** A workspace per journey keeps context tight. You can have several workspaces; you can't have one that's useful for everything.
- **Correct the discovered map before you build on it.** Claude will miss the service that's not cloned, the event that's deprecated, the consumer in another team's repo. Add what it can't see — that's the whole point of you being in the loop.
- **Contracts are first-class context.** Where schemas live and who consumes them is the single most useful thing to tell Claude in this architecture.
- **Note the services you *don't* own.** A line in the map — "owned by Payments team, we consume `PaymentAuthorised`, we don't change it" — stops Claude proposing edits you can't make.
- **Read before you approve.** Catch a wrong assumption while it's still free to fix.

## 🎁 Bonus — go further

- **Prove the contract guardrail works.** Ask Claude to rename a field on an event one of your services publishes. With `contracts.md` and the ADR in place it should *push back*, list the consumers in the workspace, and suggest a versioned or additive change instead. If it doesn't, strengthen the rule with a `YOU MUST` / `IMPORTANT` directive and try again.
- **Generate the diagram your team's been meaning to draw.** Ask Claude to render the journey as a Mermaid sequence diagram *and* a component diagram into `docs/journey/`, and check it against what you know. Fix the gaps — you've just produced the onboarding doc the team never had time for.
- **Seed the services.** Open a small PR in one service repo adding the thin `CLAUDE.md` Claude drafted. Watch how a teammate on another journey benefits from it too.

---

← Previous: [Welcome](../README.md)  ·  Next: [Exercise 2 — Spec-driven development →](./2-spec-multirepo.md)
