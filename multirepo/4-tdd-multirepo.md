`Multirepo track · Exercise 4 of 8` — [Welcome](../README.md)

# Exercise 4 — Build it test-first, in two loops (multirepo)

**Track:** Multirepo · **Time:** ~30 min
**Builds on:** the spec you drafted with `/specify` at the end of Exercise 3. · **Adds to your build:** a RED-GREEN rule that separates the *fast local loop* from the *slow dev-environment loop*, and that change implemented test-first.

> **Why it matters:** left to its own devices, Claude writes the implementation first and then tests shaped to fit the code it just wrote — so a test you never saw fail proves nothing. Forcing **RED → GREEN** is what makes a test mean something. But in your estate there's a second problem: *"we can't run tests locally — there's a dotnet project that runs against dev."* If the only test is a 20-minute run against a shared environment, nobody does RED-GREEN, and Claude has no fast "am I done" signal. The fix is to **split the loops**: a fast, local, in-service test for the logic, and the dev-environment run as the slow outer check — and to make Claude respect that split.

---

## Why this exercise

You'll add a rule that makes Claude build **test-first against a spec's acceptance criteria**, using the fast loop for everything it can and the dev-environment run only for what genuinely needs it. Then you'll use it to implement the change you spec'd last exercise: a failing local test that fails for the right reason, *then* the minimum code to pass, *then* one dev-environment run to prove the criterion that can't be proven locally.

## Before you start

- The **spec from Exercise 3** (`specs/<change>.md`), with acceptance criteria split into local-provable and dev-only.
- Know how to run the dev-environment test project (the exact `dotnet test` command and any env vars). If you built `/dev-test` in the Exercise 3 bonus, you're ahead.
- A working **local** test command in the service you're changing. **Doesn't have one?** That's Step 0 — budget extra time.

## Steps

**0. No fast local test in that service? Stand one up first.** Skip to step 1 if the service already has a unit test project that runs in seconds.

```text
The service in <service-folder>/ has no fast local tests — the only tests are in the
dev-environment project. Before setting anything up, ask me: the test framework (recommend the
idiomatic one for this stack — xUnit/NUnit for .NET — but let me choose), and whether the
message handlers and HTTP endpoints here can be exercised in-process with fakes for the
broker, database and downstream HTTP (recommend the idiomatic way to do that for this
stack, e.g. an in-memory bus / WebApplicationFactory / test containers). Then set up my
chosen framework in <service-folder>/, add the command to that service's CLAUDE.md and the
root CLAUDE.md service table, and write one characterisation test around an existing handler
that proves it runs. Keep it minimal.
```

> **Characterisation tests are your friend here.** A test that pins down *what a handler currently does* — given this message, it writes this row and publishes that event — is both your first fast test and a piece of the diagnosis work your team's already doing. Claude writes them well; you verify them against what you believe is true.

**1. Add the two-loop RED-GREEN rule to your context.** Paste this:

```text
Add an always-on rule to .claude/rules/testing.md titled "Building from a spec — RED-GREEN in
two loops (YOU MUST)": when implementing a change that has a spec in specs/, work test-first
against its acceptance criteria.
FAST LOOP — for every criterion marked local-provable: (1) write a test IN THE AFFECTED
SERVICE's test project that captures it (fake the broker, database and downstream HTTP;
never call the dev environment from these tests), no implementation yet; (2) run it and SHOW
me it fails for the right reason — behaviour missing, not a typo (RED); (3) write the minimum
code to pass, then run that test and that service's full local suite (GREEN, no regressions);
(4) refactor if useful, keeping green; move to the next criterion.
SLOW LOOP — only after every local criterion is green: for each criterion marked dev-only,
run the dev-environment test project ONCE for the relevant journey/tag (not the whole suite),
summarise the result, and STOP for me if it fails — do not guess-and-rerun against dev.
NEVER modify a test just to make it pass — if a criterion is ambiguous or a test looks wrong,
STOP and ask me. If a contract/event changes, the fast loop MUST include a test on each
consumer in this workspace proving it still handles the old shape. Show me the rule file and
stop.
```

**2. Commit before you implement.** Commit the rule file in the workspace, and anything pending in the service repo, so the diff you review in Exercise 5 is just this change.

**3. `/clear`, then hand Claude just the spec.** Clear so what happens next is the rule doing the work:

```text
/clear
```

```text
Implement specs/<your-change>.md.
```

That's the whole prompt. You already made two-loop RED-GREEN a `YOU MUST` rule — restating it would be asking Claude to do what it's required to do. If you want to confirm the rule is driving it, ask Claude which rule it's following before it starts.

**4. Watch the RED before the GREEN — locally.** The bit that makes it real is seeing the in-service test fail for the right reason *before* any implementation. If Claude jumps straight to green, or reaches for the dev environment to "check", make it back up.

**5. Then watch the slow loop run once.** When all local criteria are green, Claude runs the dev-environment project for your journey tag, once, and summarises. If it fails: read the failure *with* Claude, decide whether it's your change or the environment, and fix deliberately — not by re-running until it goes green.

## What good looks like

- **`.claude/rules/testing.md`** with the two-loop RED-GREEN rule, always on.
- **A fast local test you saw fail first**, mapped to an acceptance criterion — then pass. Written inside the service, with the broker/DB/HTTP faked.
- **That service's local suite green.**
- **One deliberate dev-environment run** proving the dev-only criterion — not a dozen hopeful ones.

## Tips & watch-outs

> **💰 Token-smart:** a fast local test is the objective "done" signal that ends the guess → run → correct churn. Running the dev-environment suite in that loop instead is the most expensive mistake in this track — minutes per run, shared-environment flakiness, and huge logs pulled into context. Keep dev for the final check, and have Claude summarise its output rather than paste it.

- **"We can't test locally" is usually "we can't test *everything* locally."** Handler logic, mapping, validation, idempotency — all testable in-process with fakes. Only the real integration (does the broker deliver, does the downstream team's service respond) needs dev. Push as much as possible into the fast loop.
- **The classic cheat is Claude weakening the test to pass.** The "never modify the test" line prevents it — call it out if you see it.
- **"Show me the RED"** is the whole discipline. If it jumps to green, make it back up.
- **Dev-environment failures aren't always yours.** Someone else's deploy, stale data, a flaky downstream. Have Claude read the failure and tell you *which service* it implicates before anyone changes code.
- **Consumer tests on contract changes are non-negotiable.** If you added a field to an event, every consumer in the workspace gets a test proving it tolerates both shapes. That's the cheapest protection you'll ever buy against a 2 a.m. page.

## 🎁 Bonus — go further

- **Backfill a characterisation test for a past incident.** Take a production bug that crossed services. Reproduce the triggering message as a failing in-service test, confirm the fix keeps it green — that failure mode can never silently return.
- **Add a contract test.** For your most-consumed event, generate a schema snapshot test in the publisher and a "can deserialise the published sample" test in each consumer. Ask Claude how your stack does this idiomatically (Pact, Verify snapshots, a shared sample-message fixture).
- **Make the dev run smarter.** If you built `/dev-test` in Exercise 3, have it tag each run with a correlation ID and pull just the matching log lines from your observability tool on failure. The slow loop gets a little faster every time.
- **Coming next:** Exercise 5 reviews this change in a fresh context, across every repo it touched. Exercise 7 puts a hook in front of `git commit` so the fast suite runs deterministically.

---

← Previous: [Exercise 3 — Skills](./3-skills-multirepo.md)  ·  Next: [Exercise 5 — Review →](./5-review-multirepo.md)
