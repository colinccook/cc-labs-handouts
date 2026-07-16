`Brownfield track · Exercise 7 of 8 · optional` — [Overview & index](./README.md)

# Exercise 7 — Connect Claude to your own systems (brownfield)

**Track:** Brownfield · *Advanced / optional* · **Time:** ~30 min (guided)
**Builds on:** everything — this is about extending Claude *outward*. · **Adds to your build:** a working read-only MCP server for one of your systems.

> **Why it matters:** you've used MCP servers other people built. But your org has internal systems with no off-the-shelf server. The `mcp-builder` skill scaffolds one, so Claude can query *your* systems the same way it queried Playwright earlier. This is where "connect Claude to everything we run" starts.

---

## Why this exercise

This is aspirational and guided — a genuinely useful server rarely fits a workshop slot, so the goal is *"I can see how we'd wire Claude into our stack,"* not a shipped server. You'll scaffold a **read-only** server for one internal system with two tools, connect it, and ask one real question.

> **⚠ Read-only, always.** A workshop is the wrong place to give an agent write access to an internal system. Scope every tool to reads.

## Before you start

- A system with an API you can hit read-only (an OpenAPI spec or a read-only view).
- A **test credential** ready (auth is the #1 thing that stalls this).

## What you'll do

1. Install the `mcp-builder` skill.
2. Scaffold a read-only server with two tools (`search_*`, `get_*`).
3. Connect it (`/mcp`) and ask a question that forces a tool to fire.

## The prompt

> Install `mcp-builder` (`/plugin marketplace add anthropics/claude-plugins-official` → `/plugin install mcp-builder@claude-plugins-official` → `/reload-plugins`). Then scaffold a **read-only** MCP server exposing one of my internal systems — start with two tools (e.g. `search_<thing>` and `get_<thing>`), auth via a bearer token from an env var. Generate the server, the tool definitions, and the `.mcp.json` wiring. Then let me run `/mcp` to confirm it connects and ask one real question that forces a tool to fire.

## What good looks like

- **A scaffolded server** with two read-only tools and its `.mcp.json` wiring.
- **`/mcp` shows it connected.**
- **Claude answers a real question from your system**, live — the payoff moment.

## Tips & watch-outs

- **Read-only only** — reads, never writes.
- **Have a test credential ready** or demo against a mock/sandbox API; auth stalls rooms.
- **Keep the toolset tiny** — many tools eat context; check with `/context`.
- **Most people won't finish, and that's fine** — the horizon is the point.

## 🎁 Bonus — go further

- **CLI already exists?** If your system has a clean CLI, Claude can just drive it — no server needed, no context overhead. Compare the two approaches.
- **Add a third tool** only if it earns its context cost.

## If you get stuck

No safe internal system to hand? Scaffold against a **public** read-only API instead — the mechanics are identical.

---

← Previous: [Exercise 6 — Subagents](./6-subagents-brownfield.md)  ·  Next: [Exercise 8 — Headless CI →](./8-ci-brownfield.md)
