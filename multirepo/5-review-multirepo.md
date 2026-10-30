`Multirepo track · Exercise 5 of 8` — [Welcome](../README.md)

# Exercise 5 — Review the change across repos, in a fresh context (multirepo)

**Track:** Multirepo · **Time:** ~30 min
**Builds on:** the spec from Exercise 3 and the tested change from Exercise 4. · **Adds to your build:** a reviewed change committed in each affected repo, linked PRs — and the fresh-context, whole-journey review habit.

> **Why it matters:** when Claude builds in minutes, *review* becomes the bottleneck — and the worst judge of the code is the session that just wrote it, still anchored on its own reasoning. The fix is a **fresh context** that sees only the diff and the spec. In a multi-repo change there's a second trap: reviewing each repo's diff on its own. A perfectly fine PR in the publisher and a perfectly fine PR in the consumer can still be wrong *together* — a field renamed in one and not the other, a deploy order that breaks for an hour. The review has to see **the whole change, across every repo, against the spec**.

---

## Why this exercise

You'll close a loop pass properly for the first time — reviewing the change **by hand**, across every repo it touched, and feeling why *where* you review matters. Review in the same session that built it (biased), then `/clear` and review again (honest — nothing but the diffs and the spec). Fix what's real, then commit in each repo and open linked PRs. Next exercise you'll capture this into a one-command agent — but first, feel it.

## Before you start

- The change from Exercise 4 in the working tree of each affected service (uncommitted is fine — you'll review *before* committing).
- Its spec (`specs/<change>.md`) with the services-touched and contracts-touched tables.

> **Working in the provided `cc-labs-exercise` solution?** It ships a `code-reviewer` subagent at `.claude/agents/code-reviewer.md` whose `description` is broad enough to short-circuit the by-hand exercise. Delete or rename it before you start; you can bring it back in Exercise 6's bonus.

## Steps

**1. Review it in the same session — and watch it defend itself.** In the *same* session that built it:

```text
Review your change against specs/<change>.md's acceptance criteria and its services-touched
and contracts-touched tables. What doesn't meet them, and what are the risks?
```

Notice the tone: it justifies the choices it just made. That anchoring bias is the stale context talking.

**2. Now `/clear` and review again — fresh, and across every repo.** Clearing drops the build transcript, so the review starts from nothing but the diffs and the spec. Paste:

```text
Review my current change against specs/<change>.md. It spans several service repos in this
workspace: for EACH service listed in the spec's services-touched table, cd into it and run
git diff (and git status for untracked files) to see its changes. Then review the change as a
whole, not repo by repo:
- map every acceptance criterion to the diff(s) that satisfy it; list unmet ones;
- for every contract/event/API in the contracts-touched table, confirm the publisher change
  and every consumer change are consistent with each other — field names, types, nullability,
  versioning — and that each consumer still tolerates the old shape;
- check the change is safe in the spec's rollout order (what happens if only the first
  service is deployed?);
- look for the usual cross-service risks with evidence: non-idempotent handlers, missing
  correlation/causation IDs, retries that would duplicate side effects, swallowed exceptions
  in handlers, ordering assumptions;
- list anything changed outside the task's scope, and any service in the table with NO diff.
Don't fix and don't nitpick style — just report, then give a verdict: ship / needs-changes /
discuss.
```

Same code, sharper read — and the "service in the table with no diff" check alone catches the most common multi-repo mistake: forgetting a repo.

**3. Fix what it flags.** Apply the real gaps and risks — ignore style noise — and re-run the fresh review if the change was substantial.

**4. Close the loop — commit in each repo and open linked PRs.** Now that it's reviewed, make one clean commit per repo and open PRs that reference each other, so a reviewer on any one of them can see the whole change:

```text
For each service in the spec's services-touched table that has changes: commit them with a
clear, focused message (what changed and why, and the journey/spec it belongs to). Then push
each and open a PR in each repo. Every PR description must: summarise the whole cross-service
change, link to the spec, list the OTHER PRs in this change with their URLs, state the
rollout order and which PR must merge/deploy first, say how to test it (fast local suite, and
the dev-environment run with its tag), and note any risks the review flagged. Open them in
rollout order and fill in the cross-links once you have all the URLs.
```

That's the terminus of every pass: **spec → build → test → review → commit → linked PRs** — then `/clear` and start the next one clean.

## What good looks like

- **A reviewed change, committed once per repo, with PRs open and cross-linked.**
- You saw the *same* change reviewed two ways — biased in-session, honest after `/clear` — and felt the difference.
- The gaps it found were real — an unmet criterion, a consumer not updated, a deploy-order hazard — and you fixed them before the PRs.
- **Each PR tells the whole story**, so a teammate reviewing just the consumer PR knows what the publisher is doing.

## Tips & watch-outs

> **💰 Token-smart:** `/clear` between tasks sheds context you no longer need. Several repos' diffs add up — if a review is huge, that's a sign the change should have been split in the spec. Letting Claude drive `git`/`gh` across N repos is convenient but spends tokens; once comfortable, a small script that commits and opens linked PRs is instant and free (Exercise 3's "capture your repeated work" bonus).

- **Review the change, not the repos.** The question is "is the *journey* correct after this?", not "is this diff tidy?"
- **Report gaps, not style.** A reviewer told to "find problems" over-reports. Keep it on unmet criteria, consistency across contracts, and real risks.
- **Don't let AI-written tests be the only gate.** A model can write tests that match its own code. A fresh-context review is a second, differently-biased check — and in this architecture, the dev run is a third.
- **The PR cross-links are not optional.** Service PRs get reviewed by different people on different days. Without the links, nobody sees the whole change — and the rollout order gets lost.

## 🎁 Bonus — go further

- **Compare with the built-in.** Run `/code-review low` in one service — Claude's bundled reviewer, zero setup. Notice it only sees that repo; the cross-service consistency check is exactly what it can't do.
- **Add the security lens.** Run `/security-review` on each service's change — that's your dedicated security pass, which is why the prompt above stays on correctness.
- **Review the rollout, not just the code.** Ask Claude: *"Walk through deploying these PRs one at a time in the stated order. After each deploy, what's running in dev, and does the journey still work end to end?"* This catches the "both PRs are fine, the hour between them isn't" class of bug.
- **Coming next:** you'll turn this exact review into a one-command reviewer **agent** (Exercise 6), so you get the fresh-context, whole-journey read *without* `/clear`-ing your session.

---

← Previous: [Exercise 4 — TDD](./4-tdd-multirepo.md)  ·  Next: [Exercise 6 — Agents →](./6-agents-multirepo.md)
