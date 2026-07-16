# Hands-on with Claude Code — Exercises

> **New here? Read the [intro](./intro.md) first** — what Part 2 is, what you'll leave with, and how to pick your track.

Welcome. These exercises are the hands-on half of the workshop. They're not a tour of Claude Code's features — they're a **build**. Each one leaves a real artifact in your project, and they stack: by the end of day 2 you'll have a running thing **you** built, plus a repeatable spec → build → test loop you can keep using on Monday. The goal isn't "I tried Claude" — it's "I ship faster with Claude."

## Pick your track

Each exercise comes in two versions — do the one that matches the code you brought:

- **Brownfield** (`N-brownfield.md`) — you're working in a repo you already have. *This is where Claude Code shines.*
- **Greenfield** (`N-greenfield.md`) — you're starting something new from an idea.

Same technique in both; only the starting point differs. **Stay on one track** — each page links to the next in the same track.

> **No repo of your own on the day?** Fall back to the sample app (`cc-labs-exercise`) from the prerequisites and follow the **brownfield** track — everything works there too.

## How each exercise works

1. A ~10-minute talk introduces the technique.
2. You run the exercise (~30 min) — read the intro, paste the prompt, review what Claude proposes, and make it yours.
3. Finished early? Every exercise has a **🎁 Bonus** section to push further.

Each page tells you up front what it *adds to your build*, and ends with a "what good looks like" check so you know you've got it.

## The exercises

| # | Exercise | Brownfield | Greenfield |
|---|----------|-----------|-----------|
| 0 | Set up your context | [→](./0-context-brownfield.md) | [→](./0-context-greenfield.md) |
| 1 | Write the spec before you build | [→](./1-spec-brownfield.md) | [→](./1-spec-greenfield.md) |
| 2 | Turn your workflow into a skill | [→](./2-skills-brownfield.md) | [→](./2-skills-greenfield.md) |
| 3 | Build it test-first (RED → GREEN) | [→](./3-tdd-brownfield.md) | [→](./3-tdd-greenfield.md) |
| 4 | Make your guardrails automatic (hooks) | [→](./4-hooks-brownfield.md) | [→](./4-hooks-greenfield.md) |
| 5 | Run two Claudes at once (worktrees) | [→](./5-worktrees-brownfield.md) | [→](./5-worktrees-greenfield.md) |
| 6 | Build a specialist subagent *(optional)* | [→](./6-subagents-brownfield.md) | [→](./6-subagents-greenfield.md) |
| 7 | Connect Claude to your systems *(optional)* | [→](./7-mcp-brownfield.md) | [→](./7-mcp-greenfield.md) |
| 8 | Let it run without you *(showcase)* | [→](./8-ci-brownfield.md) | [→](./8-ci-greenfield.md) |

**Start with [Exercise 0](./0-context-brownfield.md) (brownfield) or [Exercise 0](./0-context-greenfield.md) (greenfield).**

## A couple of conventions you'll notice

- Greenfield starts by writing a **`docs/brief.md`** — the product at a glance. The word **"spec"** (and the `specs/` folder) shows up in Exercise 1, for a single *feature*. Two different levels, two different files.
- **Tests arrive in Exercise 3**, not before — the early skeleton runs but is untested on purpose.
