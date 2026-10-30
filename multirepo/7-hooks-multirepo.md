`Multirepo track · Exercise 7 of 8` — [Welcome](../README.md)

# Exercise 7 — Guarantee the bar with a hook, per service (multirepo)

**Track:** Multirepo · **Time:** ~30 min
**Builds on:** the whole loop — the two-loop RED-GREEN rule from Exercise 4 and the reviews from Exercises 5–6. · **Adds to your build:** a hook that works out *which service* is being committed, runs **that service's fast suite** with a coverage bar, and refuses the commit if a contract changed without its consumers.

> **Why it matters:** everything you've built so far runs on instructions, and instructions are nondeterministic — Claude follows them most of the time, but that isn't a guarantee. A **hook** is a shell command Claude Code runs programmatically on a lifecycle event — it runs, identically, every time. You'll put one in front of `git commit`, so **every commit in every service** has to clear its fast suite before it's allowed. And you'll add the one deterministic check this architecture most needs: *a contract file changed → did a consumer change too?*

---

## Why this exercise

You'll wire one hook that runs one script. The multi-repo twist is that the hook lives in the **workspace** (so your team inherits it) but the commit happens in a **service folder** — so the script has to work out which repo is being committed and run *its* tests, not the whole estate's. The other fiddly part is that **test and coverage commands vary per service** — so the first move is having Claude work out how each one actually tests, rather than you guessing.

> **⚠ Security:** hooks run arbitrary shell with *your* permissions, with no confirmation prompt. Read what Claude writes before you wire it.

## Before you start

- A change you can commit in at least one service — anything left over from the loop is fine.
- The fast local test command for that service (Exercise 4), in the root `CLAUDE.md` service table.

## Steps

**1. Make commits predictable: always `git -C <service>`.** The hook needs to know which repo is being committed. The reliable way is a convention, not clever parsing:

```text
Add to .claude/rules/conventions.md (always-on): "YOU MUST run git commands against a service
with git -C <service-folder> ... from the workspace root — never cd into a service and run
git there. This lets the commit hook identify the repo." Show me the change and stop.
```

**2. Have Claude work out how each service really tests.** Commands differ per service, so don't guess:

```text
For each service folder in the root CLAUDE.md service table, work out exactly how its FAST
tests and coverage run. Read whatever applies: CI config, *.csproj / *.sln, package.json,
Makefile, pyproject.toml. Then report per service:
(1) the exact command to run its fast unit tests only — not the dev-environment project,
    not integration or e2e;
(2) the exact command to run them with a line-coverage report;
(3) whether the coverage tool can fail the run by itself under a threshold (coverlet's
    /p:Threshold, pytest-cov's --cov-fail-under, Jest/Vitest coverageThreshold) — I want the
    tool doing the failing, not a script grepping output.
Also tell me: which folders are contract locations (event/message classes, OpenAPI/proto,
shared contract packages) per docs/journey/ and .claude/rules/contracts.md — I'll need the
paths for a second check. If a service has no coverage tool, say which is idiomatic. Don't
wire a hook yet — just report, and tell me what you're unsure about.
```

Read the report and correct it. For .NET the gate is usually `dotnet test /p:CollectCoverage=true /p:Threshold=90 /p:ThresholdType=line` — needs **`coverlet.msbuild`**; the default `coverlet.collector` has no threshold, and you must not install both. Other stacks: `pytest --cov=<pkg> --cov-fail-under=90`; Jest/Vitest `--coverage` with a `coverageThreshold` / `coverage.thresholds` in config.

**3. Pick a bar you'll actually leave switched on.** On services that have never measured coverage, 90% *global* won't be today's number — and a gate that's red the minute you wire it just gets deleted. Either lower the threshold per service to something you can hold today and raise it over time, or — the one that really works on legacy services — **require 90% on changed lines only**:

```text
Change my coverage check so it requires 90% line coverage on the lines the current branch
changes in a given service, leaving untouched code alone. diff-cover is the usual answer and
isn't Python-only — it reads Cobertura or LCOV, which coverlet and most runners emit. Give me
the exact command, parameterised by service folder, and the exit code when it fails.
```

**4. Run it yourself and check the exit code.** Before it guards anything, prove it in a plain terminal, in one service:

```bash
<your command for one service>; echo "exit: $?"
```

You need to see **both** outcomes: `0` when the bar is met, non-zero when it isn't. **The exit code is the entire contract** — a check that prints "FAIL" and exits `0` guards nothing.

**5. Write the gate script — it must find the service first.** Two checks in one script: the fast suite for the committed service, and the contract/consumer check.

```text
Write .claude/hooks/commit-gate.sh — a script for a PreToolUse hook guarding git commit in
this multi-repo workspace. It reads the hook JSON from stdin and takes tool_input.command.
(1) Identify the target repo: parse the `-C <path>` argument from the git command (that's our
    convention); if there's no -C, exit 2 with the message "commit with git -C <service> from
    the workspace root so the gate knows which repo to test".
(2) Run that service's fast test + coverage command (use a small case/lookup keyed on the
    folder name, with the per-service commands from the report above) from inside that folder.
    If it fails, print a SHORT stderr message — which service, which check, the coverage
    number or failing test names, not the whole log — and exit 2.
(3) Contract check: run git -C <service> diff --cached --name-only; if any staged path matches
    the contract locations for that service, then require EITHER that at least one other
    service in the workspace has uncommitted or recently committed changes on the current
    branch (a consumer being updated in the same change) OR that the commit message, passed in
    the command, contains "[additive]" or "[contract-ok: <reason>]". Otherwise print "contract
    <file> changed but no consumer in this workspace changed and no [additive]/[contract-ok]
    marker — run @contract-checker" to stderr and exit 2.
Exit 0 silently when everything passes. Exit 2 is what blocks; stderr is the only thing
Claude gets to act on, so make it actionable. Keep it short, bash, chmod +x. Show me the
script and stop.
```

Read it — especially the parsing and the contract-path list. Then wire it in the **workspace's** `.claude/settings.json` (committed, so your team inherits the gate):

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "if": "Bash(git *commit*)",
            "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/commit-gate.sh",
            "timeout": 300
          }
        ]
      }
    ]
  }
}
```

`matcher` narrows to `Bash` calls; **`if` narrows further to commits** — note the `git *commit*` glob so `git -C payment-service commit` matches. Nothing runs on any other command. `timeout` is in seconds — cap it so a hung suite can't hold your session. Run **`/hooks`** to confirm it registered.

**6. Prove it blocks — twice.** First, raise one service's threshold a couple of points above where it is and ask Claude to commit there:

```text
Commit my current changes in <service> with a clear message.
```

Watch the commit get **blocked before it runs**, your stderr message come back as Claude's feedback, and Claude write the missing tests to get through. Put the threshold back.

Then the contract check: touch an event class in a publisher, stage it alone, and ask Claude to commit. Watch it get blocked with the "no consumer changed" message — and watch Claude reach for `@contract-checker` to work out what to do. Nobody had to remember.

## What good looks like

- **A convention** (`git -C <service>`) that makes the committed repo identifiable.
- **Per-service coverage commands that fail on their own** when the bar isn't met.
- **`.claude/hooks/commit-gate.sh`** — finds the service, runs *its* fast suite, checks contract changes have consumers or a marker; exits `2` with a message worth acting on.
- **A `PreToolUse` hook scoped with `if`**, visible in `/hooks`, committed in the workspace.
- **You watched two commits get blocked** — one on tests, one on a contract — and watched Claude clear them.
- **A bar you'll leave switched on.** 90% on changed lines counts.

## Tips & watch-outs

> **💰 Token-smart:** the gate runs *one service's fast suite* per commit — seconds, not the dev environment. Never put the dev-environment test project in a hook: a slow gate is one you'll remove within a week, and the dev run belongs in the slow loop, deliberately, once.

- **⚠ Hooks run arbitrary shell with your permissions**, with no confirmation prompt. Only wire commands you'd happily type yourself.
- **Exit codes are the contract.** `0` = proceed, `2` = block and send stderr to Claude, **anything else** = non-blocking error — the command runs anyway and Claude never hears about it. A failing check that exits `1` guards nothing.
- **Don't mix exit 2 with JSON output** — Claude Code ignores the JSON when you exit `2`. Pick one.
- **`if` is best-effort, not security.** It deliberately *fails open* when it can't parse the command, so the gate occasionally runs on a `git` call that isn't a commit. Harmless, but don't lean on `if` for a hard deny.
- **The contract check is a heuristic, and that's fine.** "Another service changed too, or you told me why not" catches the forgetful case — which is the common one. The `[additive]` / `[contract-ok]` marker is an *audit trail*, not a bypass: a reviewer will see it in the log.
- **This guards commits made through Claude Code in the workspace.** A teammate's `git commit` in a terminal isn't touched — so each service's CI still has to hold the bar, same command, same number.
- **A hook is a floor, not a ceiling.** Coverage says the lines *ran*; the contract check says a consumer *changed*. Neither says it's *right* — that's what the reviewers in Exercises 5–6 and the dev run are for.

## 🎁 Bonus — go further

- **Move the thresholds out of the script.** Put `<Threshold>90</Threshold>` in each test `.csproj` (or the equivalent in each service's config) so it's one versioned number per service, and ship those as small PRs into the service repos — the gate then follows the service everywhere, including CI.
- **Gate the push as well.** Same script, `if: "Bash(git *push*)"`. A good fit for a service whose fast suite is a bit too slow for every commit.
- **Protect contracts you don't own.** A `PreToolUse` hook on `Edit|Write` that exits `2` when the path is under a service marked *external/consumed-only* in your journey map — Claude gets told "we don't own this; propose the change to the <team> team instead".
- **Add a formatter hook.** A `PostToolUse` hook with `"matcher": "Edit|Write"` that runs `dotnet format` (or your stack's equivalent) on the file just touched — formatting never drifts across a dozen repos.
- **Let a model make the judgement call.** For the fuzzy question — "is this event change *semantically* backwards compatible?" — a hook can be `"type": "prompt"` or `"type": "agent"` instead of `"command"`. Slower and nondeterministic, so keep the test and contract-path checks as shell and reach for this only for genuinely fuzzy rules.
- **Coming next:** Exercise 8 runs the whole loop solo — and every commit in every service now has to clear this bar.

---

← Previous: [Exercise 6 — Agents](./6-agents-multirepo.md)  ·  Next: [Exercise 8 — Make it yours →](./8-loop-multirepo.md)
