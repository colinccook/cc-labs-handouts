`Brownfield track · Exercise 7 of 8` — [Welcome](../README.md)

# Exercise 7 — Guarantee the bar with a hook (brownfield)

**Track:** Brownfield · **Time:** ~25 min
**Builds on:** the whole loop — the RED-GREEN rule from Exercise 4 and the reviews from Exercises 5–6. · **Adds to your build:** a hook that runs your unit tests before every commit and blocks it below 90% line coverage.

> **Why it matters:** everything you've built so far runs on instructions, and instructions are nondeterministic — Claude will follow them most of the time, but that isn't a guarantee. A **hook** is a shell command Claude Code runs programmatically on a lifecycle event, so it isn't a matter of following anything: it runs, identically, every time. You'll put one in front of `git commit`, so **every commit** has to clear your suite and your coverage bar before it's allowed to happen.

---

## Why this exercise

You'll wire one hook that runs one command. The only fiddly part is that **the test and coverage commands vary with your tech stack and setup** — so the first move is having Claude work out how *this* repo actually tests, rather than you guessing. Then you put the gate in front of `git commit` and watch it refuse one.

> **⚠ Security:** hooks run arbitrary shell with *your* permissions, with no confirmation prompt. Read what Claude writes before you wire it.

## Before you start

- A change you can commit — anything left over from the loop is fine.

## Steps

**1. Have Claude work out how *your* repo really tests.** The commands differ per repo, so don't guess — ask:

```text
Work out exactly how tests and coverage run in this repo. Read whatever applies: CI config,
package.json scripts, Makefile, pyproject.toml/tox.ini, pom.xml/build.gradle, *.csproj.
Then report:
(1) the exact command to run the unit tests only — not the slow integration or e2e suites;
(2) the exact command to run them with a line-coverage report;
(3) whether the coverage tool can fail the run by itself when coverage is under a threshold
    (pytest-cov's --cov-fail-under, Jest/Vitest coverageThreshold, coverlet's /p:Threshold,
    JaCoCo's check rule, and so on) — I want the tool doing the failing, not a script
    grepping its output.
If no coverage tool is installed, tell me which one is idiomatic here and what installing it
would change. Don't wire a hook yet — just report, and tell me what you're unsure about.
```

Read the report, correct it where it's wrong, then let Claude install and configure coverage if it's missing. Recognise yours in here:

| Stack | The gate is usually |
|---|---|
| **pytest** | `pytest --cov=<pkg> --cov-fail-under=90` |
| **Jest** | `jest --coverage`, with `coverageThreshold: { global: { lines: 90 } }` in the config |
| **Vitest** | `vitest run --coverage`, with `coverage.thresholds.lines: 90` in the Vite config |
| **Go** | `go test -coverprofile=cover.out ./...` then `go tool cover -func=cover.out` — no built-in gate, so the `total:` line has to be compared |
| **.NET** | `dotnet test /p:CollectCoverage=true /p:Threshold=90 /p:ThresholdType=line` — needs the **`coverlet.msbuild`** package; the `coverlet.collector` in the default template has no threshold, and you must not install both |
| **Maven / Gradle** | JaCoCo's `check` (Maven) or `jacocoTestCoverageVerification` (Gradle), with a `LINE` `COVEREDRATIO` minimum of `0.90` — on Gradle add `check.dependsOn jacocoTestCoverageVerification`, or it never runs |

**2. Pick a bar you'll actually leave switched on.** On a mature codebase that has never measured coverage, 90% *global* is very unlikely to be today's number — and a gate that's red the minute you wire it just gets deleted. Two ways to land somewhere honest:

- **Adjust the threshold in the command above** to a number you can hold today, and raise it over time. Simplest option, and a floor that only goes up still helps.
- **Switch to 90% on the lines you changed only** — new and modified code must clear 90%, untouched code is left alone. This is the one that really works on legacy code.

For the second, run this. Otherwise adjust the threshold in the command above and move on:

```text
Change my coverage check so it requires 90% line coverage on the lines my current branch
changes, and leaves untouched code alone. diff-cover is the usual answer and isn't Python-only
— it reads Cobertura or LCOV, which most runners can emit. Note that Jest/Vitest changed-file
coverage is NOT the same thing: it scores whole changed files, not changed lines. Give me the
exact command and what exit code it returns when the check fails.
```

**3. Run it yourself and check the exit code.** Before it guards anything, prove it in a plain terminal:

```bash
<your command from step 1 or 2>; echo "exit: $?"
```

You need to see **both** outcomes: `0` when the bar is met, non-zero when it isn't. Nudge the threshold a couple of points above your current number to watch it fail, then put it back. **The exit code is the entire contract** — a check that prints "FAIL" and exits `0` guards nothing.

**4. Put the gate in front of `git commit`.** Two pieces: a script that runs your check, and a `PreToolUse` hook that fires it whenever Claude is about to commit.

```text
Write .claude/hooks/test-gate.sh — a script for a PreToolUse hook that guards git commit. It
should run <the command you verified in step 3> from the project root, exit 0 silently if it
passes, and if it fails print a SHORT message to stderr — which check failed, the actual
coverage number, the names of failing tests, not the whole log — then exit 2. Exit 2 is what
blocks the commit, and stderr is the only thing Claude gets to act on, so make it actionable.
It doesn't need to read stdin. Keep it short and chmod +x it. Show me the script and stop.
```

Then wire it in `.claude/settings.json` (committed, so your team inherits the gate):

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "if": "Bash(git commit*)",
            "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/test-gate.sh",
            "timeout": 300
          }
        ]
      }
    ]
  }
}
```

`matcher` narrows the group to `Bash` calls; **`if` narrows it further to `git commit`**, so nothing runs on any other command — the hook process isn't even spawned. That one line is why this needs no guard logic of its own. `timeout` is in seconds (the default for command hooks is 10 minutes — cap it lower so a hung suite can't hold your session). Config changes are normally picked up by a file watcher, so there's nothing to restart; run **`/hooks`** to confirm it registered.

**5. Prove it blocks.** Raise your threshold a couple of points above where you actually are, so the gate fails but is still clearable. Then ask Claude to commit:

```text
Commit my current changes with a clear message.
```

Watch the commit get **blocked before it runs**, your stderr message come back as Claude's feedback, and Claude write the missing tests to get through. Nobody had to remember — that's the difference from a rule. Put your threshold back when you're done.

## What good looks like

- **A coverage command that fails on its own** when the bar isn't met — the tool doing the work, not a script parsing text.
- **`.claude/hooks/test-gate.sh`** — short, executable, exits `2` with a message worth acting on.
- **A `PreToolUse` hook scoped with `if`**, visible in `/hooks`, committed so your team inherits it.
- **You watched a commit get blocked** and watched Claude clear it.
- **A bar you'll leave switched on.** 90% on changed lines counts.

## Tips & watch-outs

> **💰 Token-smart:** gating the commit rather than every turn is the cheap shape — the suite runs once per commit, not once per message, and Claude only pays for a fix when the gate actually fails. Keep it to unit tests, never e2e: a slow gate is one you'll end up removing.

- **⚠ Hooks run arbitrary shell with your permissions**, with no confirmation prompt. Only wire commands you'd happily type yourself.
- **Exit codes are the contract.** `0` = proceed, `2` = block the tool call and send stderr to Claude, **anything else** = a non-blocking error: the command runs anyway, you get a hook-error notice, and Claude never hears about it. A failing check that exits `1` is a gate that isn't guarding anything.
- **Don't mix exit 2 with JSON output** — Claude Code ignores the JSON when you exit `2`. Pick one mechanism.
- **`if` is best-effort, not security.** It checks subcommands and `$( )` too, and deliberately *fails open* when it can't parse the command — so the gate occasionally runs on a `git` call that isn't a commit. Harmless (an extra check, never a missed one), but don't lean on `if` for a hard deny; that's what the permission system is for.
- **This guards commits made through Claude Code.** Your own `git commit` in a terminal isn't touched, so CI is still what holds the bar for the whole team — same command, same number, in both places.
- **Set the bar where you can clear it.** That's what step 2 is for — 90% on changed lines beats a global 90% you never reach.
- **A hook is a floor, not a ceiling.** 90% line coverage says the lines *ran*, not that they're *right*. It stops the suite quietly rotting; it doesn't replace the review you built in Exercises 5–6.

## 🎁 Bonus — go further

- **Move the threshold out of the command.** Right now `90` lives in whatever command your hook runs. Put it in committed config instead — `fail_under = 90` under `[tool.coverage.report]` in `pyproject.toml`, `coverageThreshold` in your Jest config, `<Threshold>90</Threshold>` in the test `.csproj` — so it's one versioned number rather than a string in a hook.
- **Gate the push as well, or instead.** Same script, `if: "Bash(git push*)"`. Later and coarser than per-commit, but a good fit if your suite is too slow to run on every commit.
- **Add a formatter hook.** A `PostToolUse` hook with `"matcher": "Edit|Write"` that runs your formatter on the file Claude just touched — the cheapest useful hook there is, and formatting never drifts in the first place.
- **Protect a path.** A `PreToolUse` hook that exits `2` when Claude tries to edit `.env`, a lockfile, or generated code — it gets told why and picks another route.
- **Let a model make the judgement call.** For checks that aren't a clean pass/fail, a hook can be `"type": "prompt"` or `"type": "agent"` instead of `"command"` — Claude (Haiku by default) evaluates the condition and returns `{"ok": false, "reason": "..."}`. Nothing to enable, they work as-is, though the docs flag agent hooks as experimental and may change them. Slower, costs tokens, and not deterministic, so keep them for genuinely fuzzy rules — a coverage gate should stay a shell command.
- **Browse the rest.** Run `/hooks` to see every event you could hang something off — `SessionStart`, `UserPromptSubmit`, `Stop`, `SubagentStop`, `PreCompact` and plenty more.
- **Coming next:** Exercise 8 runs the whole loop solo — and every commit you make in it now has to clear this bar.

---

← Previous: [Exercise 6 — Agents](./6-agents-brownfield.md)  ·  Next: [Exercise 8 — Make it yours →](./8-loop-brownfield.md)
