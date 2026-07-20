`Brownfield track · Exercise 0 of 6` — [Welcome](./README.md)

# Exercise 0 — Set up your repo's context (brownfield)

**Track:** Brownfield — you brought a repo you already work in.
**Time:** ~30 min · **You'll leave with:** a thin `CLAUDE.md`, a set of `.claude/rules/`, and at least one decision captured as an ADR.

> **The bigger picture:** these exercises aren't about *trying out* Claude Code — they're about turning it into a permanent part of how you ship. Each one leaves a real improvement in your repo, and by the end of day 2 you'll have a repeatable spec → build → test loop running on your own code, making you measurably faster. This first exercise gives Claude the context to stop guessing about your project.

---

## Why this exercise

Claude is only as good as the context it carries into each message — your commands, your conventions, and the *why* behind decisions already baked into your codebase. Most repos give it none of that, so it re-derives (and sometimes fights) your architecture every session. The fix isn't a giant `CLAUDE.md` — it's a **thin one that points at what you already have**, plus a few focused rules that load only when relevant.

> **One idea to hold onto:** your `CLAUDE.md` is a *table of contents, not an encyclopedia*. If it's already written down (README, docs, ADRs), link to it — don't copy it in, or you'll maintain it twice and Claude will get the stale copy.

## Before you start

- Your repo open, building and running, with `claude` running inside it.
- A rough sense of your commands (run, test, lint) and where your docs live.

## Steps

**1. Propose the context setup.** Paste this — Claude inventories your existing docs and proposes a modular setup (a thin `CLAUDE.md` plus rules), then stops for your approval:

```text
Analyse this repo — config, layout, a few source files. First inventory the docs I
already have (README.md, docs/, ADRs, CONTRIBUTING.md) because CLAUDE.md should point
at those, not duplicate them. Then propose a modular context setup:

1. A thin root CLAUDE.md (<40 lines): commands, ~5 always-true rules, and a "where the
   detail lives" section linking my existing docs by path.
2. .claude/rules/*.md splitting concerns — conventions.md + testing.md (always-on),
   plus one paths:-scoped lazy rule per major code area (api, ui, db) with the right glob.
3. If I have ADRs, a tiny always-on architecture.md rule pointing at docs/adr/.
   Don't duplicate docs I already have.
4. If this is a large repo or monorepo, tell me whether a nested .claude/ (or CLAUDE.md)
   inside a subproject would help — context that loads only when I'm working in that
   area — and where you'd put it.

Show me the file tree and each file's contents, and STOP for approval before creating anything.
```

**2. Review and create.** Read the proposal. Trim anything bloated, fix anything wrong, then let it create the files.

**3. Capture a decision as an ADR — by hand.** Find an **architecture decision or pattern** already baked into your code or a long CLAUDE.md (a "we do X, not Y, because Z" kind of thing) and ask Claude to capture it as an ADR — **add a new one to your existing `docs/adr/`, or if you don't have any yet, make it your solution's first ADR** (`docs/adr/0001-*.md`) — with a one-line pointer left behind.

## What good looks like

By the end you should have, and be able to point at:

- **A thin `CLAUDE.md`** that *routes* to your docs instead of restating them — run `/context` and see how little it costs.
- **`.claude/rules/`** with a couple of always-on rules and at least one `paths:`-scoped rule that only loads when Claude touches that area.
- **At least one ADR** (`docs/adr/`) capturing a real decision that used to live only in someone's head — plus the tiny `architecture.md` rule pointing at it.

## Tips & watch-outs

> **💰 Token-smart:** your `CLAUDE.md` and always-on rules reload on *every* message — bloat here is a tax you pay all day. Keep it a table of contents, not an encyclopedia, and run `/context` before and after to watch the always-on cost drop.

- **Don't over-split.** 3–4 rule files beat 15. If a rule is short and universal, leave it in `CLAUDE.md`.
- **`paths:` globs are the skill.** Too broad (`src/**`) and it's eager-in-disguise; too narrow and it never fires.
- **The captured *why* is the payoff.** Your rules *and* ADRs together — not any one file — are what stop Claude from helpfully undoing a deliberate decision later.
- **Read before you approve.** Catch a wrong assumption while it's still free to fix.

## 🎁 Bonus — go further

Done early, or want to push it? Try any of these:

- **Prove the ADR guardrail works.** Ask Claude to make a change that quietly contradicts the decision you just captured. With the `architecture.md` rule in place it should *push back* and cite the ADR rather than just doing it. That pushback is the whole point.
- **Try an emphatic rule.** Rewrite one rule as a `YOU MUST …` / `NEVER …` line and watch how much harder Claude leans on it than a softly-worded version. Save the strong phrasing for the rules that really matter.
- **Compare against `/init`.** Run `/init` and see the `CLAUDE.md` Claude generates on its own, then diff it against your hand-tuned thin one. Or even change the prompt above to tell claude to make use of the `init` skill in the first place.
- **See the before/after budget.** Run `/context` before and after this exercise and watch the always-on token count drop. Also note that as your session goes on the context window fills up. 

---

← Previous: [Welcome](./README.md)  ·  Next: [Exercise 1 — Spec-driven development →](./1-spec-brownfield.md)
