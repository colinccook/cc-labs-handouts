`Brownfield track · Exercise 7 of 7` — [Welcome](./README.md)

# Exercise 7 — Run the loop, then make it yours (brownfield)

**Track:** Brownfield · **Time:** ~45–60 min (and beyond)
**Builds on:** everything — Exercises 1–6. · **Adds to your build:** another real, shipped change — and *your* version of the loop, written down.

> **Why it matters:** you've assembled the whole loop one piece at a time. This is where it stops being six exercises and becomes *one motion you own*. Nothing new to learn — just run the full loop yourself, notice where it helps and where it fights you, and tune it to how you actually work. That tuning is what makes it stick on Monday.

---

## The loop, in one place

Everything you've built connects into a single repeatable cycle:

1. **Thin context** — CLAUDE.md + rules point Claude at your docs/ADRs *(Ex 1)*.
2. **Spec** — `/specify` drafts it; you edit until the acceptance criteria are right *(Ex 2–3)*.
3. **Build test-first** — RED → GREEN, so "done" is proven *(Ex 4)*.
4. **Review** — the `reviewer` agent checks the working diff against the spec in a fresh context *(Ex 5–6)*.
5. **Fix** — apply what the review flagged.
6. **Commit & open a PR** — a clean, reviewed diff, ready for a human.

Then `/clear` and go again. Each pass should feel faster and cleaner than the last.

## Do a full pass, solo

Pick a fresh task — a feature, a bug, a refactor — and take it through the **entire** loop yourself, no hand-holding: `/specify` it, edit the spec, build it test-first, run your `reviewer` agent, fix what it flags, commit and open a PR. Complete at least one full pass; keep going if you're flowing.

## Observe as you go

You're the scientist now. Notice:

- **Where did it save you time?** Which step earned its keep?
- **Where did Claude get it wrong** — and did the loop *catch* it (a spec gap, a red test, a review finding)?
- **Where did you have to intervene**, or fight the process?
- **What felt like friction** you'd skip in a hurry?

## Make it yours

Tune the loop to *your* needs — small changes, right now:

- **CLAUDE.md / rules** too thin or too noisy? Adjust (watch `/context`).
- **`/specify`** asking the wrong questions? Edit the skill.
- **`reviewer` agent** missing things, or too chatty? Sharpen its prompt and what it ignores.
- **Steps you'd drop or add** for your kind of work? Decide — and write it down.

## What good looks like

- **A second real change shipped** through the full loop, solo.
- **An honest read** on what worked and what didn't for *you*.
- **At least one deliberate tweak** to your context, skill, or agent — the loop is now yours, not the workshop's.

## Tips & watch-outs

> **💰 Token-smart:** the loop *is* the cost story — a pass that specs, tests, and reviews wastes far fewer tokens on rework than "just build it." If a pass felt expensive, look at where you *re-did* work, not just where tokens went.

- **Don't add ceremony you won't keep.** A one-line fix doesn't need a spec. Match the loop's weight to the risk.
- **The tweak is the point.** A loop you adapted is one you'll use; a loop you copied you'll abandon.
- **Faster each pass is the signal.** If it isn't, something in your setup is fighting you — find it.

## 🎁 Bonus — go further

- **Write down "my loop."** One index card: your steps, your commands (`/specify`, `reviewer`), your "done" checklist. That's your real takeaway.
- **Teach it to one person.** The fastest way to keep a workflow is to show a teammate.
- **Where next:** as the loop matures you'll want to *automate* the checks, *parallelise* independent work, *connect* Claude to your systems, and *run it unattended*. Those are the next layers on this same loop.

---

← Previous: [Exercise 6 — Agents](./6-agents-brownfield.md)  ·  [You built it — back to Welcome →](./README.md)
