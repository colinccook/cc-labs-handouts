`Multirepo track · Exercise 6 of 8` — [Welcome](../README.md)

# Exercise 6 — Capture your journey reviewer as an agent (multirepo)

**Track:** Multirepo · **Time:** ~30 min
**Builds on:** the fresh-context, cross-repo review you ran by hand in Exercise 5. · **Adds to your build:** a reusable, read-only `journey-reviewer` subagent — and the pattern for building agents for any repeatable cross-service job.

> **Why it matters:** doing the fresh-context review by hand means `/clear`-ing every time — and losing the session you were working in. A **subagent** runs in its *own* isolated context, so it gives you the same fresh-context review *on demand*, without ending your session: it gathers the diffs from every repo and the spec itself, and hands back findings. Same beat as the `/trace` and `/specify` skills in Exercise 3 — do it by hand, then capture it — except a review needs *isolation*, which is exactly what an agent gives you and a skill can't.

---

## Why this exercise

You'll turn the by-hand review into `.claude/agents/journey-reviewer.md` — cheap (Haiku), read-only, scoped to the diffs in the services the spec names — and run it against a change. That teaches the pattern for agents in general: any time you want the *same specialist judgement, repeatably, in its own clean context*, you reach for one. In this track there's a second natural agent — a **contract checker** — and you'll see why it's worth having both.

## Before you start

- Exercise 5 done — you've reviewed by hand and know what a good cross-repo review looks like.
- A committed change (across repos) and its spec to point the agent at.

## Steps

**1. Capture the review as an agent.** Paste this to build a cheap, read-only reviewer that carries its own fresh context:

```text
Create a subagent at .claude/agents/journey-reviewer.md that reviews my current cross-service
change against its spec, without fixing. Frontmatter: name: journey-reviewer; a description
listing trigger phrases ("review the change", "review across the services", "review against
the spec", "journey review"); model: haiku (keep it cheap); and tools: Read, Bash, Glob, Grep
(no Write or Edit — it must review, not change code). Body — the steps to run: (1) read the
spec I name (or the most recently modified specs/*.md) and take its services-touched and
contracts-touched tables as the scope; (2) for each service in the table, cd into its folder
and run git diff plus git status; flag any service in the table with no changes; (3) read the
root CLAUDE.md, .claude/rules/contracts.md and docs/adr/ for conventions and decisions; (4)
map every acceptance criterion to the diff(s); (5) for every contract in the table, check the
publisher and all consumer changes are mutually consistent and that consumers still accept the
old shape; (6) check the change is safe in the stated rollout order; (7) look for
non-idempotent handlers, missing correlation IDs, duplicate side effects on retry, swallowed
exceptions, ordering assumptions — with evidence; (8) report unmet criteria, inconsistencies,
risks, out-of-scope changes; do NOT fix — report only, ending with a verdict: ship /
needs-changes / discuss. Show me the file and stop.
```

**2. Run it, and keep working.** Invoke it explicitly with **`@journey-reviewer`**, or just say *"review this change across the services"*. Because of the `description`, Claude will also reach for it on its own. Read its report. It ran in its own context on Haiku, read-only and diff-scoped across N repos, so it cost a fraction of a full review — and your main session is untouched.

**3. Build the contract checker — a second, narrower agent.** Some checks are worth running *before* a review, every time a contract moves:

```text
Create a subagent at .claude/agents/contract-checker.md. Frontmatter: name: contract-checker;
description with trigger phrases ("check the contract", "is this event change safe", "did I
break any consumers"); model: haiku; tools: Read, Bash, Glob, Grep (read-only). Body: (1) from
my current diffs across the workspace, identify every changed contract — event/message classes,
OpenAPI/proto files, shared contract package versions; (2) for each, classify the change as
additive, breaking, or ambiguous, with the exact fields/types involved; (3) grep every service
folder for consumers of that contract and report which have been updated in this change and
which have NOT; (4) note any consumer that appears in docs/journey/ as external to this
workspace; (5) report as a table and end with: safe / breaking / needs-consumer-updates. Do not
fix anything. Show me the file and stop.
```

**4. Close the loop with both.** Now a pass ends without `/clear`-ing anything: build test-first → **`@contract-checker`** (if a contract moved) → **`@journey-reviewer`** → fix → commit per repo → linked PRs. Run a full pass this way on a second change and feel how much faster the review step gets. Then, when you move on to a genuinely new task, **`/clear`** — the agents keep their own context, but your main session still works best fresh.

## What good looks like

- **`.claude/agents/journey-reviewer.md`** — read-only, Haiku, scoped by the spec's services table, checks the change *as a whole*.
- **`.claude/agents/contract-checker.md`** — read-only, narrower, answers one question fast: did this break a consumer?
- **A review produced in its own context**, with your main session untouched.
- A clear sense of *when* you'd reach for an agent versus asking the main session.

## Tips & watch-outs

> **💰 Token-smart:** both agents run on Haiku, read-only, and hand back a summary rather than a transcript, so your session stays lean. Scoping the reviewer to the spec's services table — rather than "diff everything in the workspace" — is what keeps it cheap across a dozen repos.

- **Agent or skill?** A *skill* is a set of steps in your current session (`/trace`, `/specify`). An *agent* is a whole task you **hand off** to its own isolated context with its own model and toolset — reach for one when you want to delegate a self-contained job, run several in parallel, or enforce a specific lens (like this read-only reviewer).
- **Read-only, always.** Leaving Write/Edit out of `tools:` is what stops it "helpfully" rewriting a consumer mid-review. (`Bash` is there for `git diff` across folders.)
- **Scope by the spec.** A reviewer that diffs every repo in the workspace is slow, noisy and expensive. The spec's services table is the scope — and "a service in the table with no diff" is a finding, not a gap.
- **Two small agents beat one big one.** The contract checker is fast and decisive; the journey reviewer is broader. Running the narrow one first means the broad one has less to find.
- **Report gaps, not style** — same discipline as the by-hand review.

## 🎁 Bonus — go further

- **Run them in parallel.** Ask Claude to run `@contract-checker` and `@journey-reviewer` at the same time on the same change and merge the findings. Agents in isolated contexts are the natural unit of parallelism.
- **Build a third — the `incident-tracer`.** Given a correlation ID or a failing dev test name, it reads the journey map, greps handlers for the relevant message types, and proposes *which service* most likely failed and *why* — before anyone opens a dashboard. Read-only, Sonnet (it needs to reason), and it's the diagnosis assistant your team has wanted.
- **Right-size the model.** Haiku is right for the default review. For a contract change on your most-consumed event, make a `journey-reviewer-strong` variant on Sonnet at higher effort and reach for it only when the risk warrants.
- **Compare with the built-in.** `/code-review low` is the bundled reviewer — but it reviews one repo. Rule of thumb: the built-in for a quick single-service pass, *your* agent when the change crosses a boundary.

---

← Previous: [Exercise 5 — Review](./5-review-multirepo.md)  ·  Next: [Exercise 7 — Hooks →](./7-hooks-multirepo.md)
