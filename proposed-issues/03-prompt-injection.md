---
title: Cover prompt-injection risk from untrusted input
labels: content-gap,security,priority:high
---

**Files:** `*/2-spec-*.md` (GitHub-issue bonus), `*/8-loop-*.md` (MCP mention)

## Problem
Ex 2 encourages *"read issue #123 with gh and draft a spec from it"*, and Ex 8 points at MCP. Nowhere do we say that issue bodies, web pages, dependency READMEs and MCP tool output are **untrusted text that can contain instructions**.

## Why it matters
Prompt injection is the main security risk for coding agents. An agent with shell access that reads a malicious issue, PR comment or web page can be steered into leaking secrets or running commands. We are actively directing learners toward external input, so we should name the risk at the exact point we do it — otherwise we're teaching the attack surface without the defence.

## Proposed change
- Add a short ⚠ callout next to the GitHub-issue bonus and the MCP mention.
- Recommend least-privilege toolsets and deny rules (links to the permissions issue).
- Recommend reviewing any actions the agent takes after reading external content, and installing only trusted MCP servers.

## Acceptance criteria
- [ ] Callout present in both tracks wherever external content is read.
- [ ] Cross-references the permissions content.

> _Feature names and flags here move between Claude Code releases — verify against current docs before editing the handouts (see the version-pinning issue)._

_Raised from a course review of current agentic-coding practice._
