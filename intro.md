`Hands-on with Claude Code · Part 2` — [Overview & index](./README.md)

# Welcome to Part 2 — put it all together on *your* code

**Part 1** gave you the pieces: what Claude Code is, how to prompt it, the tools it can reach, where it fits in your day. **Part 2 is where those pieces become a workflow** — and where you stop practising on toy examples and start applying everything to a real solution you care about.

Over the next day and a half you'll take the individual moves you learned and stack them into one repeatable loop: **set up context → spec → build → test → automate → scale.** By the time you leave, that loop won't be a slide — it'll be running in your own repo, and you'll know how to keep using it on Monday.

> **This is a build, not a demo.** Each exercise leaves a real artifact in your project. Nothing here is throwaway — you're doing the actual work, just faster, and learning the technique by shipping with it.

---

## What you'll walk away with

- **A running thing *you* built** — on the code you brought, or on a new idea you started here.
- **A repeatable spec → build → test loop** you can point at any feature, any repo.
- **Guardrails that travel with the code** — context files, tests, hooks, and subagents that keep quality high without you babysitting every prompt.
- **Enough fluency to keep going alone** — the whole point of day 2 is that you leave *enabled*, not dependent on the room. Monday you open your repo and the flow is already there.

## The through-line: agentic engineering, not vibe coding

There are two ways to work with a model like this.

- **Vibe coding** — prompt until something looks like it works, ship it, hope. It's fast and fun for a weekend hack, and it produces code no one can trust or maintain. Fine for a throwaway; a liability in production.
- **Agentic engineering** — you give Claude the *context, specs, tests, and guardrails* to do real work, then you review and steer. The output is production-grade: reviewable, tested, consistent with your conventions, safe to hand to the next person.

Every exercise in Part 2 is one more piece of that second discipline. A CLAUDE.md so Claude knows your rules. A spec so it builds the right thing. Tests so "done" means *proven*. Hooks so quality is automatic. Worktrees and subagents so you scale past one conversation. That's the difference between *trying* Claude and *engineering* with it — and it's what turns "700 devs have access" into "700 devs ship better, faster."

## Pick your starting point — and switch to it now

The exercises come in two tracks. **Choose one and stay on it.**

- **Brownfield — bring your own repo.** Work in a solution you already have. *This is where Claude Code earns its keep* — real constraints, real legacy, real conventions. If you brought code, this is your track. **Open that repo now.**
- **Greenfield — start something new.** No repo, or want a clean slate? You'll stand up a fresh project from an idea and grow it. **Open an empty folder now.**

> **The scope in one line:** take everything from Part 1 and drive it into a solution that matters to you — existing or new — and come out the other side delivering value *at quality*.

**No code of your own on the day?** Use the sample app (`cc-labs-exercise`) from the prerequisites and follow the **brownfield** track — every technique works there too.

## How the day flows

1. A short talk (~10 min) introduces each technique.
2. You run the matching exercise (~30 min) on your own code — read the intro, paste the prompt, **review what Claude proposes, and make it yours.**
3. Finished early? Every exercise has a **🎁 Bonus** to push further.

The exercises **stack** — each builds on the artifact the last one left behind — so do them in order and stay on your track.

---

**Ready?** Open your repo (or an empty folder), then start with **Exercise 0**:
[Brownfield →](./0-context-brownfield.md)  ·  [Greenfield →](./0-context-greenfield.md)

← [Overview & index](./README.md)
