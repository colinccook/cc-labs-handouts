`Hands-on with Claude Code · Part 2`

# Welcome to Part 2 — put it all together on *your* code

**Part 1** gave you the pieces: what Claude Code is, how to prompt it, the tools it can reach, where it fits in your day. **Part 2 is where those pieces become a workflow** — and where you stop practising on toy examples and start applying everything to a real solution you care about.

Over the next day and a half you'll take the individual moves you learned and stack them into one repeatable loop: **set up context → spec → build → test → review → automate → scale.** By the time you leave, that loop won't be a slide — it'll be running in your own repo, and you'll know how to keep using it on Monday.

> **This is a build, not a demo.** Each exercise leaves a real artifact in your project. Nothing here is throwaway — you're doing the actual work, just faster, and learning the technique by shipping with it.

---

## What you'll walk away with

- **A running thing *you* built** — on the code you brought, or on a new idea you started here.
- **A repeatable spec → build → test loop** you can point at any feature, any repo.
- **Guardrails that travel with the code** — context files, tests, a reviewer agent, and hooks that keep quality high without you babysitting every prompt.
- **Enough fluency to keep going alone** — the whole point of day 2 is that you leave *enabled*, not dependent on the room. Monday you open your repo and the flow is already there.

## The through-line: agentic engineering, not vibe coding

There are two ways to work with a model like this.

- **Vibe coding** — prompt until something looks like it works and move on. It's fast, and it's genuinely great for a prototype or spike where you're exploring an idea. The catch is that the code tends to be hard to trust or maintain once you have to live with it.
- **Agentic engineering** — you give Claude the *context, specs, tests, and guardrails* to do real work, then you review and steer. The output is production-grade: reviewable, tested, consistent with your conventions, safe to hand to the next person.

Every exercise in Part 2 is one more piece of that second discipline. A CLAUDE.md so Claude knows your rules. A spec so it builds the right thing. Tests so "done" means *proven*. A fresh-context review so quality is checked, not assumed. Hooks so quality is automatic. Worktrees so you scale past one conversation. That's the difference between *trying* Claude and *engineering* with it.

> **💰 Token-smart throughout.** Every message re-sends your context, so *how* you work is what drives what you spend. The structured loop is the cheapest habit of all: a spec stops Claude building the wrong thing and burning tokens on rework, and a runnable check ends the guess-and-retry churn. Keep an eye on `/context`, `/clear` between unrelated tasks, and watch for the **💰 Token-smart** notes in each exercise — small levers that add up.

## Pick your starting point — and switch to it now

The exercises come in two tracks. **Choose one and stay on it.**

- **Brownfield — bring your own repo.** Work in a solution you already have. *This is where Claude Code earns its keep* — real constraints, real legacy, real conventions. If you brought code, this is your track. **Open that repo now.**
- **Greenfield — start something new.** No repo, or want a clean slate? You'll stand up a fresh project from an idea and grow it. **Open an empty folder now.**

**No code of your own on the day?** Use the sample app (`cc-labs-exercise`) from the prerequisites and follow the **brownfield** track — every technique works there too.

> **Before you start:** open a terminal (or the integrated terminal in VS Code) inside your chosen folder — the empty one for greenfield, your existing solution for brownfield — and launch `claude` there. And **use source control**: initialise git if you haven't, and commit regularly as you go, so you can always see what Claude changed and roll back a step you don't like. You can even ask Claude to commit for you.

## How the day flows

1. A short talk (~5–10 min) introduces each technique.
2. You run the matching exercise (~30–45 min) on your own code — read the intro, paste the prompt, **review what Claude proposes, and make it yours.**
3. Finished early? Every exercise has a **🎁 Bonus** to push further.

The exercises **stack** — each builds on the artifact the last one left behind — so do them in order and stay on your track.

> **The setup is the start, not the whole thing.** Each exercise gets Claude *configured* to work well — but once that part's done, keep going: use the rest of the slot to do **real implementation work** on your project. You can build throughout the day. In fact, watch how the *quality of what Claude produces climbs* as your setup matures — thin context and no tests early on, versus specs, guardrails, and a subagent later. That improving output is the whole point of Part 2.

---

**Ready?** Open your repo (or an empty folder), then start with **Exercise 0**:
[Brownfield →](./0-context-brownfield.md)  ·  [Greenfield →](./0-context-greenfield.md)
