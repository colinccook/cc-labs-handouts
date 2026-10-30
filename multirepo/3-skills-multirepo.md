`Multirepo track · Exercise 3 of 8` — [Welcome](../README.md)

# Exercise 3 — Turn your cross-repo workflows into skills (multirepo)

**Track:** Multirepo · **Time:** ~30 min
**Builds on:** the spec-drafting you did by hand in Exercise 2. · **Adds to your build:** a reusable `/specify` skill, a `/trace` skill that follows a journey through the repos — and a spec ready to build in Exercise 4.

> **Why it matters:** a skill captures *the way you do X here* once, so it persists across sessions and teammates — and fires automatically when a task matches. In a multi-repo estate the repeated work isn't just "draft a spec" — it's "trace this event end-to-end", "find every consumer of this message", "run the dev tests for this journey". You type those paragraphs every day… unless you capture them.

---

## Why this exercise

You'll turn two of your most repeated cross-repo moves into one-keystroke skills: `/specify` (from Exercise 2) and `/trace`, which follows a journey step or event through every repo in the workspace and reports who publishes, who consumes, and where the contract lives. `/trace` is the skill your team's *diagnosis* work has been missing — and `/specify` will call it.

## Before you start

- Exercise 2 done — you've got `specs/_template.md` and the spec-drafting flow fresh in mind.
- The journey map in `docs/journey/` from Exercise 1.

## Steps

**1. Build the `/trace` skill first.** This is the building block the spec skill will lean on:

```text
Create a skill at .claude/skills/trace/SKILL.md that traces a journey step, event, message,
or API call across every service repo in this workspace. Self-contained — assume a fresh
session. Frontmatter: name; a specific description listing trigger phrases ("trace",
"who consumes", "who publishes", "where does <event> go", "follow this through the
services"); argument-hint: <event, message type, endpoint or journey step>. Body — the steps:
(1) read docs/journey/ and the root CLAUDE.md for the service table and contract locations;
(2) grep every service folder for the type/topic/route — publishers, consumers, handlers,
schema definitions, and any shared contract package versions in use; (3) build the chain:
service → event/call → service, noting sync vs async, retries, idempotency keys, and any
dead-letter handling you can see; (4) flag anything consumed but never published (or vice
versa) within this workspace — that's a service we don't have cloned or a dead path; (5)
report as a short table plus a Mermaid sequence diagram, and list what you're unsure about.
Read-only — it must not change any code. Show me the finished SKILL.md and stop.
```

**2. Build the `/specify` skill — and make it call `/trace`.** Capture the Exercise 2 workflow as a self-contained skill:

```text
Create a skill at .claude/skills/specify/SKILL.md that drafts a cross-service change spec for
this workspace. It must be self-contained — assume a fresh session with no prior conversation.
Frontmatter: name; a specific description that lists trigger phrases ("write a spec", "spec
this change", "specify ..."); argument-hint: <change>; and set model: opus with effort: high —
spec quality is worth the strongest model (falls back to my session model if I don't have
Opus). Body — the steps to run when invoked: (1) read docs/journey/, .claude/rules/contracts.md
and docs/adr/; (2) use the /trace skill on every event, message or API the change could touch,
so the consumer list is grounded in code, not memory; (3) read the code in each affected
service; (4) open specs/_template.md, creating a lean one if it's missing; (5) fill every
section — especially the services-touched and contracts-touched tables and rollout order —
asking me one question at a time for anything you can't confidently infer; (6) write the
result to specs/<kebab-change>.md; (7) STOP for review — do NOT write any implementation.
Show me the finished SKILL.md and stop.
```

**3. Trigger them two ways.** Run `/trace <an event your journey publishes>` and check the chain against what you know. Then **describe the task in plain language** — "who listens to OrderPlaced?" — without naming the skill, to confirm its `description` fires it. Do the same for `/specify`.

**4. Spec the change you'll build next.** Use `/specify` to draft a spec for a **small, testable change in one service** — ideally one whose acceptance criteria can mostly be proven with a fast local test, with one criterion that needs the dev environment. You'll implement it test-first in Exercise 4. Edit until the criteria are concrete.

## What good looks like

- **`/trace <event>`** gives you the publisher→consumer chain and a diagram in seconds — the thing that used to be a morning of grepping and Slack.
- **`/specify <change>`** does in one keystroke what took a paragraph last exercise, with a consumer list grounded in `/trace`.
- Both **fire when you describe their task** in plain language.
- **A spec ready for Exercise 4**, with acceptance criteria split into local-provable and dev-only.

## Tips & watch-outs

> **💰 Token-smart:** skills load *progressively* — a skill's description sits in context every turn, but the full instructions load only when it fires. Keep descriptions tight. `/trace` greps many repos, so it can be a chunky call — that's fine once per spec; don't run it idly. For a skill you'll only ever trigger yourself, `disable-model-invocation: true` keeps even its description out of context until you call it.

- **The `description` is the trigger.** Make it specific and slightly pushy — list the phrases that should fire it. The model tends to *under*-trigger skills.
- **`/trace` is only as complete as your workspace.** A consumer in a repo you haven't cloned is invisible. The skill's "consumed but never published" flag is your prompt to go clone it — or note the external owner in the journey map.
- **Keep `SKILL.md` under ~500 lines**; push detail (e.g. your messaging conventions, topic naming rules) into a `references/` file it reads only when needed.
- **You don't have to build these from scratch.** AI-native SDD kits exist — e.g. [spec-kit](https://github.com/github/spec-kit) and [specs.md](https://specs.md/). We're hand-rolling to see how it works; `/trace` is the one you *won't* find off the shelf, because it's specific to your estate.

## 🎁 Bonus — go further

- **Build `/dev-test`.** A skill that runs your dev-environment test project for one journey or tag — knows the exact `dotnet test --filter` incantation, the environment variables, how long to wait — and returns a *summary* (failing test names, assertion messages, correlation IDs) rather than the whole log. You'll want it in Exercise 4 and it's the foundation for the hook in Exercise 7.
- **Build `/consumers`.** A narrower sibling of `/trace`: given a contract type or package, list every consumer and the version each is on. Useful before every contract change.
- **Try the built-in skills — no install.** `/simplify` does a focused cleanup pass over code you just wrote without changing behaviour. `/security-review` scans your working changes for vulnerabilities. Run them on a handler you've touched.
- **Capture a skill for your own repeated work.** Opening the N linked PRs for a change, writing the release note, scaffolding a new message handler in your team's shape — if you do it the *exact* same way every time, capture it. If nothing's genuinely repetitive, skip it.

---

← Previous: [Exercise 2 — Spec-driven](./2-spec-multirepo.md)  ·  Next: [Exercise 4 — TDD →](./4-tdd-multirepo.md)
