`Multirepo track · Exercise 8 of 8` — [Welcome](../README.md)

# Exercise 8 — Run the loop across the journey, then make it yours (multirepo)

**Track:** Multirepo · **Time:** ~45–60 min (and beyond)
**Builds on:** everything — Exercises 1–7. · **Adds to your build:** another real cross-service change shipped as linked PRs — and *your* version of the loop, written down.

> **Why it matters:** you've assembled the whole loop one piece at a time. This is where it stops being seven exercises and becomes *one motion you own* — one that spans repos without you holding the map in your head. Nothing new to learn: run the full loop yourself, notice where it helps and where it fights you, and tune it to how your team actually works. That tuning is what makes it stick on Monday.

---

## The loop, in one place

Everything you've built connects into a single repeatable cycle, run from the **journey workspace**:

1. **Journey context** — root `CLAUDE.md` maps the services, flow and contracts; rules and ADRs carry the cross-service decisions *(Ex 1)*.
2. **Trace, then spec** — `/trace` grounds the consumer list in code; `/specify` drafts a spec with the services-touched and contracts-touched tables; you edit until the acceptance criteria are right and split into local vs dev *(Ex 2–3)*.
3. **Build test-first, in two loops** — RED → GREEN in each service's fast suite; one deliberate dev-environment run for what can't be proven locally *(Ex 4)*.
4. **Review the whole change** — `@contract-checker` if a contract moved, then `@journey-reviewer` across every repo in the spec, in a fresh context *(Ex 5–6)*.
5. **Fix** — apply what the reviews flagged.
6. **Commit per repo & open linked PRs** — in rollout order, each PR telling the whole story; your hook checks the service's fast suite and the contract rule before each commit is allowed *(Ex 7)*.

Then `/clear` and go again. Each pass should feel faster and cleaner than the last.

## Do a full pass, solo

Pick a fresh change — a feature carried through two services, a bug that crosses a boundary, a contract version bump — and take it through the **entire** loop yourself, no hand-holding: `/trace` it, `/specify` it, edit the spec, build it test-first in the fast loop, run the dev check once, run your agents, fix what they flag, commit per repo and open linked PRs — with the gate holding you honest on the way through. Complete at least one full pass; keep going if you're flowing.

## Observe as you go

You're the scientist now. Notice:

- **Where did it save you time?** Which step earned its keep — was it `/trace` finding a consumer you'd forgotten?
- **Where did Claude get it wrong** — and did the loop *catch* it (a spec gap, a red test, a reviewer finding, a blocked commit)?
- **Where did you have to intervene** — a service not in the workspace, a dev failure that wasn't yours?
- **What felt like friction** you'd skip in a hurry? Be honest — that's what to fix.

## Make it yours

Tune the loop to *your* team — small changes, right now:

- **Root `CLAUDE.md` / rules** too thin or too noisy for N repos? Adjust (watch `/context`). Does a service deserve its own nested `CLAUDE.md` yet?
- **`/trace`** missing a messaging pattern you use? Teach it your topic naming, your outbox, your envelope shape.
- **`/specify`** asking the wrong questions? Edit the skill — the rollout-order question in particular.
- **`@journey-reviewer`** chatty, or blind to a risk you care about (ordering, PII in events, retries)? Sharpen its prompt.
- **The commit gate** too slow for one service, or the contract heuristic firing wrongly? Scope it, or tune the marker rule.
- **The dev run** still too painful? Decide which criteria genuinely need it and push the rest into the fast loop.
- **Steps you'd drop or add** for your kind of work? Decide — and write it down.

## What good looks like

- **A second real cross-service change shipped** through the full loop, solo, as linked PRs.
- **An honest read** on what worked and what didn't for *your* estate.
- **At least one deliberate tweak** to your context, skills, agents or hook — the loop is now yours, not the workshop's.
- **A journey map that's more correct than it was this morning** — because every pass through the loop teaches it something.

## Tips & watch-outs

> **💰 Token-smart:** the loop *is* the cost story — a pass that traces, specs, tests locally and reviews wastes far fewer tokens on rework than "just build it", and far fewer dev-environment runs. If a pass felt expensive, look at where you *re-did* work, and how many times the dev suite ran.

- **Don't add ceremony you won't keep.** A one-service, non-contract fix doesn't need a spec or a journey review. Match the loop's weight to the blast radius.
- **The tweak is the point.** A loop you adapted is one you'll use; a loop you copied you'll abandon.
- **The workspace is a team asset.** The map, the skills, the agents, the hook — push the workspace repo somewhere the team can clone. Every teammate who opens it inherits the whole setup.
- **Faster each pass is the signal.** If it isn't, something in your setup is fighting you — find it.

## 🎁 Bonus — go further

- **Write down "my loop."** One index card: your steps, your commands (`/trace`, `/specify`, `@contract-checker`, `@journey-reviewer`, `git -C`), your "done" checklist. That's your real takeaway.
- **Stand up a second journey workspace.** Same shape, different journey — and notice how much of the setup copies straight across. Pull the shared bits (`conventions.md`, the skills, the agents, the hook) into a template repo for the team.
- **Teach it to one person.** The fastest way to keep a workflow is to show a teammate — and in a multi-team estate, the fastest way to get the *other* team's service into your workspace is to show *them*.
- **Where next:** parallelising work with worktrees is below. Connecting Claude to your systems (MCP — your observability stack, your message broker's admin API, Jira) and running it unattended (CI) are further layers to explore on your own.

## 🧭 More features to try

- **Run a second Claude in parallel with worktrees.** `claude --worktree <name>` creates an isolated git worktree and starts a session there — a second Claude working alongside your main one with zero shared context. In a journey workspace the natural split is *one Claude per service* on the same change: the publisher in one worktree, the consumer in another, both reading the same spec. Be mindful of what each needs independently — its own restored packages, its own `.env`/user-secrets, its own ports if anything runs locally. Look at the `WorktreeCreate` and `WorktreeRemove` hooks for setup/teardown automation, and `git worktree remove` when you're done.
- **Point MCP at your estate.** Once you're comfortable, an MCP server for your observability tool (logs/traces by correlation ID) or your broker (list topics, peek a message) turns `/trace` and the `incident-tracer` agent from code-only into code-plus-runtime. Heavier to set up — reach for it when the code-only version is clearly the limit.

## 📚 Further reading — the sources behind Part 2

The Part 2 talks lean on three Anthropic sources. Each goes deeper than any workshop can — worth a slow read once you're back at your desk.

| Source | Why it's worth your time | Link |
|---|---|---|
| **Best practices for Claude Code** | The canonical loop — explore → plan → code → commit, verification-driven development, fresh-context review, and keeping CLAUDE.md thin. | https://code.claude.com/docs/en/best-practices |
| **Effective context engineering for AI agents** | Context as a finite budget: the attention budget, diminishing returns, "context rot," and loading the smallest high-signal set — doubly relevant with a dozen repos in view. | https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents |
| **Building effective agents** | Workflows vs agents, the augmented-LLM building block, and choosing the *right* system rather than the most complex one. | https://www.anthropic.com/engineering/building-effective-agents |

---

← Previous: [Exercise 7 — Hooks](./7-hooks-multirepo.md)  ·  [You built it — back to Welcome →](../README.md)
