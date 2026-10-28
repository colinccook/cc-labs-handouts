`Brownfield track · Exercise 7 of 8` — [Welcome](../README.md)

# Exercise 7 — Guarantee the bar with a hook (brownfield)

**Track:** Brownfield · **Time:** ~30 min
**Builds on:** the whole loop — the RED-GREEN rule from Exercise 4 and the reviews from Exercises 5–6. · **Adds to your build:** a hook that runs your unit tests before every commit and blocks it below 90% line coverage.

> **Why it matters:** everything you've built so far runs on instructions, and instructions are nondeterministic — Copilot will follow them most of the time, but that isn't a guarantee. A **hook** is a command Copilot CLI runs programmatically on a lifecycle event, so it isn't a matter of following anything: it runs, identically, every time. You'll put one in front of `git commit`, so **every commit** has to clear your suite and your coverage bar before it's allowed to happen.

---

## Why this exercise

You'll wire one hook that runs one script. There are two fiddly parts. First, **the test and coverage commands vary with your tech stack and setup** — so the first move is having Copilot work out how *this* repo actually tests, rather than you guessing. Second, Copilot CLI hooks fire on a *tool* (the shell), not on a specific command, so your script reads the tool call from stdin and decides for itself whether it's a commit. Then you put the gate in front of `git commit` and watch it refuse one.

> **⚠ Security:** hooks run arbitrary shell with *your* permissions, with no confirmation prompt. Read what Copilot writes before you wire it.

## Before you start

- A change you can commit — anything left over from the loop is fine.

## Steps

**1. Have Copilot work out how *your* repo really tests.** The commands differ per repo, so don't guess — ask:

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

Read the report, correct it where it's wrong, then let Copilot install and configure coverage if it's missing. Recognise yours in here:

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

**3. Run it yourself and check the exit code.** Before it guards anything, prove it in a plain terminal (or inside Copilot with the `!` prefix, which skips the model):

```bash
<your command from step 1 or 2>; echo "exit: $?"
```

You need to see **both** outcomes: `0` when the bar is met, non-zero when it isn't. Nudge the threshold a couple of points above your current number to watch it fail, then put it back. **The exit code is the entire contract** between the coverage tool and your script — a check that prints "FAIL" and exits `0` guards nothing.

**4. Write the gate script.** Copilot CLI hooks don't filter by command — a `preToolUse` hook can only be narrowed to a *tool* (the shell), so the script itself decides whether this particular shell call is a commit. Copilot pipes a JSON payload describing the tool call to the script's stdin, and reads one JSON decision back from its stdout.

```text
Write .github/hooks/scripts/test-gate.sh — a preToolUse hook script for GitHub Copilot CLI
that guards git commit. Copilot runs it before every shell tool call and pipes JSON on
stdin with toolName and toolArgs; toolArgs may be a JSON string or an object, and the
shell command is in its "command" field. The script must: (1) read stdin and extract the
command with jq; (2) if the command is not a git commit, exit 0 immediately with no
output — this path runs on every shell call, so keep it fast; (3) otherwise run
<the command you verified in step 3> from the project root, sending all of its
output to stderr or a temp file, never stdout; (4) if it passes, exit 0 with no output;
(5) if it fails, print exactly ONE line of JSON to stdout —
{"permissionDecision":"deny","permissionDecisionReason":"..."} — where the reason is
SHORT and actionable (which check failed, the actual coverage number, the names of failing
tests, not the whole log), then exit 0. The reason is the only thing the agent gets to act
on. Don't use set -e: any crash or unexpected non-zero exit makes Copilot deny EVERY shell
command. chmod +x it. Show me the script and stop.
```

> **No `jq`?** Install it, or ask for the same script in Python or Node — whatever your stack already has. On Windows, ask for a PowerShell twin (`test-gate.ps1`) as well.

**5. Prove the script before you wire it.** Hooks are just programs reading stdin — so feed it a fake payload in a plain terminal and check both paths:

```bash
echo '{"toolName":"bash","toolArgs":"{\"command\":\"ls\"}"}' | .github/hooks/scripts/test-gate.sh; echo "exit: $?"
echo '{"toolName":"bash","toolArgs":"{\"command\":\"git commit -m test\"}"}' | .github/hooks/scripts/test-gate.sh; echo "exit: $?"
```

The first must return instantly with no output and `exit: 0`. The second must run your suite and — with the threshold nudged above your current number — print a single `deny` JSON line, still with `exit: 0`. Pipe it through `jq .` to check it's valid JSON.

**6. Put the gate in front of `git commit`.** Wire it in `.github/hooks/test-gate.json` (committed, so your team inherits the gate):

```json
{
  "version": 1,
  "hooks": {
    "preToolUse": [
      {
        "type": "command",
        "matcher": "bash",
        "bash": "./.github/hooks/scripts/test-gate.sh",
        "cwd": ".",
        "timeoutSec": 300
      }
    ]
  }
}
```

`matcher` is a regex on the tool name, so the hook only fires for shell calls (`bash`; use `"bash|powershell"` plus a `"powershell"` key if anyone on the team is on Windows). Everything finer — *is this a commit?* — is the script's job. **`timeoutSec` matters more than it looks:** the default is 30 seconds, and **a timed-out hook fails *open*** — the commit just goes through. Set it comfortably above your suite's runtime. Hook files are read when the CLI starts, so run **`/restart`**, then **`/env`** to confirm the hook is loaded.

**7. Prove it blocks.** Raise your threshold a couple of points above where you actually are, so the gate fails but is still clearable. Then ask Copilot to commit:

```text
Commit my current changes with a clear message.
```

Watch the commit get **denied before it runs**, your reason come back to Copilot as the explanation, and Copilot write the missing tests to get through. Nobody had to remember — that's the difference from a rule. Put your threshold back when you're done.

## What good looks like

- **A coverage command that fails on its own** when the bar isn't met — the tool doing the work, not a script parsing text.
- **`.github/hooks/scripts/test-gate.sh`** — short, executable, silent on non-commits, and a single `deny` JSON line with a reason worth acting on when the bar isn't met.
- **`.github/hooks/test-gate.json`** — a `preToolUse` hook matched to the shell, with a timeout sized to your suite, visible in `/env`, committed so your team inherits it.
- **You watched a commit get blocked** and watched Copilot clear it.
- **A bar you'll leave switched on.** 90% on changed lines counts.

## Tips & watch-outs

> **💰 Token-smart:** gating the commit rather than every turn is the cheap shape — the suite runs once per commit, not once per message, and Copilot only pays for a fix when the gate actually fails. The script *starts* on every shell call, so keep the not-a-commit path instant. Keep it to unit tests, never e2e: a slow gate is one you'll end up removing.

- **⚠ Hooks run arbitrary shell with your permissions**, with no confirmation prompt. Only wire commands you'd happily type yourself.
- **Know how a `preToolUse` hook can answer.** Exit `0` with no output = carry on through the normal permission flow. Exit `0` with `{"permissionDecision":"deny","permissionDecisionReason":"…"}` = blocked, and the reason goes to the agent — that's the clean, actionable path. Exit `2` = denied too. A crash or any other non-zero exit = *also* denied (**fail-closed**), with a generic "hook errored" message instead of your reason — so a buggy script blocks *every* shell command, not just commits. Test it with piped input first.
- **Timeouts fail *open*.** If the hook doesn't finish within `timeoutSec` (default 30s), Copilot logs a warning and lets the command run. A slow suite with the default timeout is a gate that silently isn't guarding — size the timeout to the suite.
- **One JSON object on stdout, nothing else.** Copilot parses the whole of stdout as a single JSON document; stray test output or two `echo`s mean "no decision" and the commit goes through. Send everything else to stderr.
- **The command check is best-effort, not security.** Matching `git commit` in a string can be sidestepped (`git -C . commit`, an alias, `sh -c "…"`). It catches the normal case, which is the point; for a hard "never" use permission rules (e.g. `--deny-tool 'shell(git push)'`), and let CI hold the line.
- **This guards commits made through Copilot CLI** — and, because `.github/hooks/` is also read by Copilot cloud agent, commits made by tasks you `/delegate` too. Your own `git commit` in a terminal isn't touched, so CI is still what holds the bar for the whole team — same command, same number, in both places.
- **Set the bar where you can clear it.** That's what step 2 is for — 90% on changed lines beats a global 90% you never reach.
- **A hook is a floor, not a ceiling.** 90% line coverage says the lines *ran*, not that they're *right*. It stops the suite quietly rotting; it doesn't replace the review you built in Exercises 5–6.

## 🎁 Bonus — go further

- **Move the threshold out of the command.** Right now `90` lives in whatever command your hook runs. Put it in committed config instead — `fail_under = 90` under `[tool.coverage.report]` in `pyproject.toml`, `coverageThreshold` in your Jest config, `<Threshold>90</Threshold>` in the test `.csproj` — so it's one versioned number rather than a string in a script.
- **Gate the push as well, or instead.** Same script, matching `git push` instead of (or as well as) `git commit`. Later and coarser than per-commit, but a good fit if your suite is too slow to run on every commit.
- **Add a formatter hook.** A `postToolUse` hook with `"matcher": "edit|create"` whose script reads the edited file's path from `toolArgs` on stdin and runs your formatter on it — the cheapest useful hook there is, and formatting never drifts in the first place.
- **Protect a path.** A `preToolUse` hook with `"matcher": "edit|create"` that returns a `deny` decision when Copilot tries to touch `.env`, a lockfile, or generated code — it gets told why and picks another route.
- **"Don't stop until it's green."** An `agentStop` hook fires when Copilot finishes a turn; if it prints `{"decision":"block","reason":"…"}`, Copilot takes another turn with your reason as the prompt. Pair it with a fast check (lint, unit tests) and Copilot can't declare victory on a red build. Use the `stop_hook_active` input field to avoid looping — the CLI gives up after 8 consecutive blocks anyway.
- **Want a model to make the judgement call?** Copilot CLI has no built-in "ask a model" hook type — hooks are commands or HTTP calls. For genuinely fuzzy rules, the best home is usually your reviewer agent or instructions, not a hook. If you really need it in a hook, the script can call `copilot -p "…" --model <cheap model>` non-interactively and turn the answer into a decision — but it's slow, costs tokens, isn't deterministic, and the nested session loads the same repo hooks, so guard against it re-triggering itself. A coverage gate should stay a plain command.
- **Browse the rest.** The [hooks reference](https://docs.github.com/en/copilot/reference/hooks-reference) lists every event you could hang something off — `sessionStart`, `userPromptSubmitted`, `postToolUseFailure`, `agentStop`, `subagentStop`, `preCompact` and more. Run `/env` any time to see what's loaded.
- **Migrating from Claude Code?** Copilot CLI will also run Claude-format `PreToolUse` hooks found in `.claude/settings.json`. Handy as a bridge — but move them into `.github/hooks/` so cloud agent and your teammates' Copilot sessions pick them up too.
- **Coming next:** Exercise 8 runs the whole loop solo — and every commit you make in it now has to clear this bar.

---

← Previous: [Exercise 6 — Agents](./6-agents-brownfield.md)  ·  Next: [Exercise 8 — Make it yours →](./8-loop-brownfield.md)
