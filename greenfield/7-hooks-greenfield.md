`Greenfield track · Exercise 7 of 8` — [Welcome](../README.md)

# Exercise 7 — Guarantee the bar with a hook (greenfield)

**Track:** Greenfield · **Time:** ~20–25 min
**Builds on:** the whole loop — the test harness from Exercise 4 and the reviews from Exercises 5–6. · **Adds to your build:** a hook that runs your unit tests before every commit and blocks it below 90% line coverage.

> **Why it matters:** everything you've built so far runs on instructions, and instructions are nondeterministic — Claude will follow them most of the time, but that isn't a guarantee. A **hook** is a shell command Claude Code runs programmatically on a lifecycle event, so it isn't a matter of following anything: it runs, identically, every time. You'll put one in front of `git commit`, so **every commit** has to clear your suite and your coverage bar before it's allowed to happen.

---

## Why this exercise

You'll wire one hook that runs one command. The only fiddly part is that **the test and coverage commands vary with your tech stack and setup** — and you chose your own runner in Exercise 4, so let Claude work out the coverage command for it. Then you put the gate in front of `git commit` and watch it refuse one.

> **⚠ Security:** hooks run arbitrary shell with *your* permissions, with no confirmation prompt. Read what Claude writes before you wire it.

## Before you start

- A change you can commit — anything left over from the loop is fine.
- Your stack from `docs/adr/0001-initial-stack.md` — it decides which coverage tool you use.

## Steps

**1. Add coverage to the runner you already chose.** Your harness runs tests; it probably doesn't measure coverage yet:

```text
Add line-coverage reporting to the test runner already configured in this repo (the test
command is in CLAUDE.md), using the idiomatic tool for my stack (see
docs/adr/0001-initial-stack.md). The coverage tool must fail the run by itself when line
coverage is under 90% — use its native threshold (pytest-cov's --cov-fail-under, Jest/Vitest
coverageThreshold, coverlet's /p:Threshold, JaCoCo's check rule) rather than a script grepping
its output. Then tell me the exact command to run it and add that command to CLAUDE.md next to
the test command. Don't wire a hook yet.
```

Recognise yours in here:

| Stack | The gate is usually |
|---|---|
| **pytest** | `pytest --cov=<pkg> --cov-fail-under=90` |
| **Jest** | `jest --coverage`, with `coverageThreshold: { global: { lines: 90 } }` in the config |
| **Vitest** | `vitest run --coverage`, with `coverage.thresholds.lines: 90` in the Vite config |
| **Go** | `go test -coverprofile=cover.out ./...` then `go tool cover -func=cover.out` — no built-in gate, so the `total:` line has to be compared |
| **.NET** | `dotnet test /p:CollectCoverage=true /p:Threshold=90 /p:ThresholdType=line` — needs the **`coverlet.msbuild`** package; the `coverlet.collector` in the default template has no threshold, and you must not install both |
| **Maven / Gradle** | JaCoCo's `check` (Maven) or `jacocoTestCoverageVerification` (Gradle), with a `LINE` `COVEREDRATIO` minimum of `0.90` — on Gradle add `check.dependsOn jacocoTestCoverageVerification`, or it never runs |

> **Take the global 90% now.** This is greenfield's one real advantage here: your whole codebase is days old, so a global threshold is cheap to satisfy today and expensive to reach later. (On a legacy repo you'd usually have to settle for 90% on *changed* lines — worth knowing for when you take this back to your real codebase.)

**2. Run it yourself and check the exit code.** Before it guards anything, prove it in a plain terminal:

```bash
<your coverage command>; echo "exit: $?"
```

You need to see **both** outcomes: `0` when the bar is met, non-zero when it isn't. Nudge the threshold a couple of points above your current number to watch it fail, then put it back to 90. (Already at 100%? Add a throwaway function with no test, watch it fail, then delete it.) **The exit code is the entire contract** — a check that prints "FAIL" and exits `0` guards nothing.

**3. Put the gate in front of `git commit`.** Two pieces: a script that runs your check, and a `PreToolUse` hook that fires it whenever Claude is about to commit.

```text
Write .claude/hooks/test-gate.sh — a script for a PreToolUse hook that guards git commit. It
should run <the coverage command you verified in step 2> from the project root, exit 0 silently
if it passes, and if it fails print a SHORT message to stderr — which check failed, the actual
coverage number, the names of failing tests, not the whole log — then exit 2. Exit 2 is what
blocks the commit, and stderr is the only thing Claude gets to act on, so make it actionable.
It doesn't need to read stdin. Keep it short and chmod +x it. Show me the script and stop.
```

Then wire it in `.claude/settings.json` (committed, so the gate ships with the project from day one):

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

**4. Prove it blocks.** Raise your threshold a couple of points above where you actually are, so the gate fails but is still clearable. Then ask Claude to commit:

```text
Commit my current changes with a clear message.
```

Watch the commit get **blocked before it runs**, your stderr message come back as Claude's feedback, and Claude write the missing tests to get through. Nobody had to remember — that's the difference from a rule. Put your threshold back to 90 when you're done.

## What good looks like

- **A coverage command that fails on its own** below 90%, with the command in `CLAUDE.md`.
- **`.claude/hooks/test-gate.sh`** — short, executable, exits `2` with a message worth acting on.
- **A `PreToolUse` hook scoped with `if`**, visible in `/hooks`, committed from day one.
- **You watched a commit get blocked** and watched Claude clear it.
- **90% enforced while it's still cheap** to enforce.

## Tips & watch-outs

> **💰 Token-smart:** gating the commit rather than every turn is the cheap shape — the suite runs once per commit, not once per message, and Claude only pays for a fix when the gate actually fails. Keep it to unit tests, never e2e: a slow gate is one you'll end up removing.

- **⚠ Hooks run arbitrary shell with your permissions**, with no confirmation prompt. Only wire commands you'd happily type yourself.
- **Exit codes are the contract.** `0` = proceed, `2` = block the tool call and send stderr to Claude, **anything else** = a non-blocking error: the command runs anyway, you get a hook-error notice, and Claude never hears about it. A failing check that exits `1` is a gate that isn't guarding anything.
- **Don't mix exit 2 with JSON output** — Claude Code ignores the JSON when you exit `2`. Pick one mechanism.
- **`if` is best-effort, not security.** It checks subcommands and `$( )` too, and deliberately *fails open* when it can't parse the command — so the gate occasionally runs on a `git` call that isn't a commit. Harmless (an extra check, never a missed one), but don't lean on `if` for a hard deny; that's what the permission system is for.
- **This guards commits made through Claude Code.** Your own `git commit` in a terminal isn't touched, so CI is still what holds the bar once other people are working on this — same command, same number, in both places.
- **Don't let the gate drive the design.** If you catch yourself writing a test purely to move the number, that's coverage theatre — the bar exists to stop untested code slipping in, not to be satisfied.
- **A hook is a floor, not a ceiling.** 90% line coverage says the lines *ran*, not that they're *right*. It stops your prototype quietly rotting as it grows; it doesn't replace the review you built in Exercises 5–6.

## 🎁 Bonus — go further

- **Move the threshold out of the command.** Right now `90` lives in whatever command your hook runs. Put it in committed config instead — `fail_under = 90` under `[tool.coverage.report]` in `pyproject.toml`, `coverageThreshold` in your Jest config, `<Threshold>90</Threshold>` in the test `.csproj` — so it's one versioned number rather than a string in a hook.
- **Gate the push as well, or instead.** Same script, `if: "Bash(git push*)"`. Later and coarser than per-commit, but a good fit once your suite is too slow to run on every commit.
- **Add a formatter hook.** A `PostToolUse` hook with `"matcher": "Edit|Write"` that runs your formatter on the file Claude just touched — the cheapest useful hook there is, and formatting never drifts in the first place.
- **Protect a path.** A `PreToolUse` hook that exits `2` when Claude tries to edit `.env`, a lockfile, or generated code — it gets told why and picks another route.
- **Let a model make the judgement call.** For checks that aren't a clean pass/fail, a hook can be `"type": "prompt"` or `"type": "agent"` instead of `"command"` — Claude (Haiku by default) evaluates the condition and returns `{"ok": false, "reason": "..."}`. Nothing to enable, they work as-is, though the docs flag agent hooks as experimental and may change them. Slower, costs tokens, and not deterministic, so keep them for genuinely fuzzy rules — a coverage gate should stay a shell command.
- **Record the decision.** A short ADR (`docs/adr/0002-test-coverage-bar.md`) saying *90% line coverage, enforced by a hook, because …* — future-you will want the reasoning before removing the gate.
- **Browse the rest.** Run `/hooks` to see every event you could hang something off — `SessionStart`, `UserPromptSubmit`, `Stop`, `SubagentStop`, `PreCompact` and plenty more.
- **Coming next:** Exercise 8 runs the whole loop solo — and every commit you make in it now has to clear this bar.

---

← Previous: [Exercise 6 — Agents](./6-agents-greenfield.md)  ·  Next: [Exercise 8 — Make it yours →](./8-loop-greenfield.md)
