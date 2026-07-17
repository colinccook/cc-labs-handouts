`Greenfield track · Exercise 7 of 8 · optional` — [Overview & index](./README.md)

# Exercise 7 — Connect Claude to your own systems (greenfield)

**Track:** Greenfield · *Advanced / optional* · **Time:** ~30 min (guided)
**Builds on:** your prototype's data needs. · **Adds to your build:** a read-only MCP server for a data source your app uses.

> **Why it matters:** you've used MCP servers other people built. When a data source your prototype needs has no off-the-shelf server, `mcp-builder` scaffolds one — so Claude can query it directly as you build. This is where "connect Claude to everything" starts.

---

## Why this exercise

Aspirational and guided. **Only do this if your prototype genuinely consumes an external or public data source** — otherwise skip to the finale. You'll scaffold a **read-only** server for that source, connect it, and ask one real question.

> **⚠ Read-only, always.** Scope every tool to reads.

## Before you start

- A data source your app uses (an external or public API), ideally with an OpenAPI spec.
- A test credential if the API needs auth (or pick one that doesn't).

## Steps

**1. Install `mcp-builder` and scaffold a read-only server.** Paste this to install the skill and scaffold a server for the external/public data source your prototype uses, with one or two read-only tools:

```text
If my prototype needs data from an external or public API, install mcp-builder (/plugin marketplace add anthropics/claude-plugins-official → /plugin install mcp-builder@claude-plugins-official → /reload-plugins) and scaffold a read-only MCP server for that source — two tools to start, auth via an env var if needed. Generate the server, tool definitions, and .mcp.json. Then /mcp to confirm it connects, and ask one real question that forces a tool to fire.
```

**2. Connect it and ask a real question.** Run `/mcp` to confirm it connects, then ask a question that forces a tool to fire.

## What good looks like

- **A scaffolded read-only server** with its `.mcp.json` wiring.
- **`/mcp` shows it connected.**
- **Claude answers a real question from that source**, live.

## Tips & watch-outs

- **Skip this if your prototype has no external data source** — don't force it; the finale is the better use of time.
- **Read-only, tiny toolset**, test credential ready.
- Aspirational — finishing isn't the point; seeing how it wires up is.

## 🎁 Bonus — go further

- **Prefer a CLI** if your source has one — Claude can drive it directly, cheaper than a server.
- **Feed it into a feature** — have your app actually use the data you can now query.

---

← Previous: [Exercise 6 — Subagents](./6-subagents-greenfield.md)  ·  Next: [Exercise 8 — Headless CI →](./8-ci-greenfield.md)
