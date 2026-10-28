`Greenfield track · Exercise 8 of 8` — [Welcome](../README.md)

# Exercise 8 — Run the loop, then make it yours (greenfield)

**Track:** Greenfield · **Time:** ~45–60 min (and beyond)
**Builds on:** everything — Exercises 1–7. · **Adds to your build:** another real feature on your prototype — and *your* version of the loop, written down.

> **Why it matters:** you've assembled the whole loop one piece at a time. This is where it stops being seven exercises and becomes *one motion you own*. Nothing new to learn — just run the full loop yourself, notice where it helps and where it fights you, and tune it to how you actually work. That tuning is what makes it stick on Monday.

---

## The loop, in one place

Everything you've built connects into a single repeatable cycle:

1. **Thin context** — `.github/copilot-instructions.md` + `.github/instructions/` point Copilot at your `docs/brief.md` and ADRs *(Ex 1)*.
2. **Spec** — `/specify` drafts it; you edit until the acceptance criteria are right *(Ex 2–3)*.
3. **Build test-first** — RED → GREEN, so "done" is proven *(Ex 4)*.
4. **Review** — the `reviewer` agent checks the working diff against the spec in a fresh context *(Ex 5–6)*.
5. **Fix** — apply what the review flagged.
6. **Commit & open a PR** — your hook checks the suite and the coverage bar before the commit is allowed, so green isn't a judgement call *(Ex 7)*.

Then `/clear` and go again. Each pass should feel faster and cleaner than the last.

## Do a full pass, solo

Pick the next slice of your brief — a feature you haven't built yet — and take it through the **entire** loop yourself, no hand-holding: `/specify` it, edit the spec, build it test-first, run your `reviewer` agent, fix what it flags, commit and open a PR — with the gate holding you honest on the way through. Complete at least one full pass; keep going if you're flowing.

## Observe as you go

You're the scientist now. Notice:

- **Where did it save you time?** Which step earned its keep?
- **Where did Copilot get it wrong** — and did the loop *catch* it (a spec gap, a red test, a review finding)?
- **Where did you have to intervene**, or fight the process?
- **What felt like friction** you'd skip in a hurry?

## Make it yours

Tune the loop to *your* needs — small changes, right now:

- **Instructions** too thin or too noisy? Adjust (watch `/context`, and check `/instructions` to see what's actually loading).
- **`/specify`** asking the wrong questions? Edit the skill, then `/skills reload`.
- **`reviewer` agent** missing things, or too chatty? Sharpen its prompt and what it ignores (then `/restart` to reload it).
- **The commit gate** too slow, or set at a bar you keep fighting? Scope it tighter or move the threshold to a number you'll actually keep.
- **Steps you'd drop or add** for your kind of work? Decide — and write it down.

## What good looks like

- **A second real feature shipped** through the full loop, solo.
- **An honest read** on what worked and what didn't for *you*.
- **At least one deliberate tweak** to your instructions, skill, agent, or hook — the loop is now yours, not the workshop's.

## Tips & watch-outs

> **💰 Token-smart:** the loop *is* the cost story — a pass that specs, tests, and reviews wastes far fewer tokens on rework than "just build it." If a pass felt expensive, look at where you *re-did* work, not just where tokens went. `/usage` breaks the session down per model, so you can see whether the expensive steps were the ones that deserved it.

- **Don't add ceremony you won't keep.** A one-line fix doesn't need a spec. Match the loop's weight to the risk.
- **The tweak is the point.** A loop you adapted is one you'll use; a loop you copied you'll abandon.
- **Faster each pass is the signal.** If it isn't, something in your setup is fighting you — find it.

## 🎁 Bonus — go further

- **Write down "my loop."** One index card: your steps, your commands (`/specify`, "use the reviewer agent", `/review`, `/security-review`), your "done" checklist. That's your real takeaway.
- **Teach it to one person.** The fastest way to keep a workflow is to show a teammate — and because everything lives under `.github/`, they get your instructions, skill, agent, and hook the moment they pull.
- **Where next:** you've already made one check unskippable — parallel work and delegation are below, ready to try now. Connecting Copilot to more of your systems (`/mcp add`) and running it unattended in CI (`copilot -p` in a GitHub Actions workflow) are further layers still to explore on your own.

## 🧭 More features to try

- **Run a second Copilot in parallel with worktrees.** `copilot --worktree <name>` (or `/worktree <branch>` / `/new worktree` from inside a session) creates an isolated git worktree on its own branch — under `<repo>.worktrees/` by default — and starts a session there: a second Copilot working alongside your main one with zero shared context. Before running two at once, be mindful of what each worktree needs independently: its own dependencies (`node_modules`/venv), its own `.env`, and its own port if a dev server or test database is involved — two on `:3000` will collide. Copilot CLI doesn't copy gitignored files like `.env` into new worktrees for you, so the best approach is a small committed setup script (say `scripts/setup-worktree.sh`) that copies `.env` from the main checkout, installs dependencies, and picks a free port — run it with `!scripts/setup-worktree.sh` as the first thing in the new session, or wire it as a `sessionStart` hook that only acts when it detects a fresh worktree (keep it idempotent and fast). And clean up when you're done: `git worktree remove` rather than letting them pile up.
- **Parallelise one task with `/fleet`.** `/fleet <prompt>` lets Copilot split a task into independent parts and run them as parallel subagents — useful once a spec breaks into genuinely separable pieces.
- **Hand a task to the cloud with `/delegate`.** Copilot cloud agent picks it up in its own sandbox and opens a PR — and it reads the same `.github/copilot-instructions.md`, `.github/instructions/`, agents, and `.github/hooks/`, so your loop's guardrails travel with it. `/pr auto` will drive an open PR to green for you.
- **Let it run with autopilot.** `copilot --plan --mode autopilot` plans first, then keeps working without waiting for you between steps. Only reach for this once your spec, tests, and hook are solid — they're what make unattended work safe.

## 📚 Further reading — the sources behind Part 2

The Part 2 talks lean on these sources. Each goes deeper than any workshop can — worth a slow read once you're back at your desk.

| Source | Why it's worth your time | Link |
|---|---|---|
| **Best practices for GitHub Copilot CLI** | Instructions, permissions, plan mode, context management, delegation — the canonical tips for the tool you've been using. | https://docs.github.com/en/copilot/how-tos/copilot-cli/cli-best-practices |
| **Comparing Copilot customization features** | When to reach for custom instructions vs skills vs custom agents vs hooks vs MCP — the map behind Exercises 1–7. | https://docs.github.com/en/copilot/concepts/customizations/comparing-customizations |
| **GitHub Copilot hooks reference** | Every hook event, payload, and decision field — including the fail-open/fail-closed rules from Exercise 7. | https://docs.github.com/en/copilot/reference/hooks-reference |
| **Effective context engineering for AI agents** *(Anthropic — tool-agnostic)* | Context as a finite budget: the attention budget, diminishing returns, "context rot," and loading the smallest high-signal set. | https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents |
| **Building effective agents** *(Anthropic — tool-agnostic)* | Workflows vs agents, the augmented-LLM building block, and choosing the *right* system rather than the most complex one. | https://www.anthropic.com/engineering/building-effective-agents |

---

← Previous: [Exercise 7 — Hooks](./7-hooks-greenfield.md)  ·  [You built it — back to Welcome →](../README.md)
