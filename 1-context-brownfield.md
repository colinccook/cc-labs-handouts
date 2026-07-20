`Brownfield track · Exercise 1 of 7` — [Welcome](./README.md)

# Exercise 1 — Set up your repo's context (brownfield)

**Track:** Brownfield — you brought a repo you already work in.
**Time:** ~30 min · **You'll leave with:** a thin `CLAUDE.md`, a set of `.claude/rules/`, and at least one decision captured as an ADR.

> **The bigger picture:** these exercises aren't about *trying out* Claude Code — they're about turning it into a permanent part of how you ship. Each one leaves a real improvement in your repo, and by the end of day 2 you'll have a repeatable spec → build → test → review loop running on your own code, making you measurably faster. This first exercise gives Claude the context to stop guessing about your project.

---

## Why this exercise

Claude is only as good as the context it carries into each message — your commands, your conventions, and the *why* behind decisions already baked into your codebase. Most repos give it none of that, so it re-derives (and sometimes fights) your architecture every session. The fix isn't a giant `CLAUDE.md` — it's a **thin one that points at what you already have**, plus a few focused rules that load only when relevant.

> **One idea to hold onto:** your `CLAUDE.md` is a *table of contents, not an encyclopedia*. If it's already written down (README, docs, ADRs), link to it — don't copy it in, or you'll maintain it twice and Claude will get the stale copy.

## Before you start

- Your repo open, building and running, with `claude` running inside it.
- A rough sense of your commands (run, test, lint) and where your docs live.

## Steps

**1. Start with `/init`.** Run it — Claude scans the repo and generates a starter `CLAUDE.md` (build/test commands, structure, conventions it can infer). This is the recommended starting point; don't hand-write from a blank page.

```text
/init
```

**2. Take it to a proper, modular setup.** `/init` gives you one file — now make it best-practice. Paste this; Claude proposes the modular structure and stops for your approval:

```text
I've just run /init, so there's a starter CLAUDE.md in the repo. Take it to a proper,
lean, modular setup — don't just leave one big file.

First inventory the docs I already have (README, docs/, any ADRs, CONTRIBUTING) —
CLAUDE.md should point at those, not duplicate them. Then propose:

1. A thin root CLAUDE.md (aim under ~40 lines): the key commands, ~5 always-true
   rules, and a "where the detail lives" section linking my existing docs by path.
   Trim anything /init added that you could just read from the code.
2. .claude/rules/ splitting concerns: a conventions.md that's always-on (eager),
   plus one or more paths:-scoped rules (lazy — loaded only when I touch that area,
   e.g. api, ui, db) with the right globs.
3. If I have ADRs, a small always-on architecture.md rule pointing at docs/adr/.
4. If this is a large repo or monorepo, tell me whether a nested CLAUDE.md inside a
   subproject would help — context that loads only when I work in that area — and
   where you'd put it.

Show me the proposed file tree and each file's contents, and STOP for my approval
before creating or changing anything.
```

**3. Review and create.** Read the proposal. Trim anything bloated, fix anything wrong, then let it create the files.

**4. Capture architecture decisions as ADRs — Claude suggests, you approve.** The point is that Claude knows the *why* behind your architecture and can defend it later. Paste this:

```text
Help me capture architecture decisions as ADRs. First review the codebase (and any
existing docs/adr/) and SUGGEST two or three decisions or conventions that aren't written
down yet — e.g. the stack choice, a layering rule, a data-access pattern. Don't write
anything yet: show me the candidates and wait for me to pick.

Then, for the one(s) I approve, write each to docs/adr/NNNN-<slug>.md in a short standard
ADR format (context, decision, consequences). Finally, create or update
.claude/rules/architecture.md (always-on) so it points at docs/adr/ as the home for these
decisions AND says when a new ADR is required — breaking changes, and decisions that are
costly to reverse. Make sure CLAUDE.md references it. Show me everything and stop.
```

Review its suggestions before it writes anything — you're the one who knows which decisions actually matter.

## What good looks like

By the end you should have, and be able to point at:

- **A thin `CLAUDE.md`** that *routes* to your docs instead of restating them.
- **`.claude/rules/`** with a couple of always-on rules and at least one `paths:`-scoped rule that only loads when Claude touches that area.
- **At least one ADR** (`docs/adr/`) capturing a real decision that used to live only in someone's head — plus the tiny `architecture.md` rule pointing at it.

## Tips & watch-outs

> **💰 Token-smart:** your `CLAUDE.md` and always-on rules reload on *every* message — bloat here is a tax you pay all day. It's a balancing act: too little and Claude guesses, too much and the rules that matter get lost in the noise. Keep it a table of contents, not an encyclopedia. Run `/context` after your setup to see the always-on cost; trim CLAUDE.md, run `/context` again, and watch that number drop (no `/clear` needed — re-running `/context` is what refreshes it).

- **Know your controls.** `/model` switches model, `/effort` sets reasoning effort (`low`→`max`), and adding `ultrathink` to a prompt forces a one-off deeper pass. You'll pick models per step as you go — a stronger model for specs, Haiku for the cheap review later.
- **Don't over-split.** 3–4 rule files beat 15. If a rule is short and universal, leave it in `CLAUDE.md`.
- **`paths:` globs are the skill.** Too broad (`src/**`) and it's eager-in-disguise; too narrow and it never fires.
- **The captured *why* is the payoff.** Your rules *and* ADRs together — not any one file — are what stop Claude from helpfully undoing a deliberate decision later.
- **Read before you approve.** Catch a wrong assumption while it's still free to fix.

## 🎁 Bonus — go further

Done early, or want to push it? Try any of these:

- **Prove the ADR guardrail works.** Ask Claude to make a change that quietly contradicts the decision you just captured. With the `architecture.md` rule in place it should *push back* and cite the ADR rather than just doing it. If it doesn't, strengthen the rule with a `YOU MUST` / `IMPORTANT` directive and try again — watch how much harder Claude leans on the emphatic phrasing. That pushback is the whole point.

---

← Previous: [Welcome](./README.md)  ·  Next: [Exercise 2 — Spec-driven development →](./2-spec-brownfield.md)
