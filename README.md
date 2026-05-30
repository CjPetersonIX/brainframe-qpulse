# brainframe-qpulse

```
██████╗ ██████╗  █████╗ ██╗███╗   ██╗███████╗██████╗  █████╗ ███╗   ███╗███████╗
██╔══██╗██╔══██╗██╔══██╗██║████╗  ██║██╔════╝██╔══██╗██╔══██╗████╗ ████║██╔════╝
██████╔╝██████╔╝███████║██║██╔██╗ ██║█████╗  ██████╔╝███████║██╔████╔██║█████╗
██╔══██╗██╔══██╗██╔══██║██║██║╚██╗██║██╔══╝  ██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝
██████╔╝██║  ██║██║  ██║██║██║ ╚████║██║     ██║  ██║██║  ██║██║ ╚═╝ ██║███████╗
╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝
                    S K I L L   ·   Q   P U L S E
```

A portable agent skill that renders a single **read-only status dashboard** — what's in
progress (with progress bars), what's queued, what's blocked, and which services are up.
One glance, no re-explaining the format.

Part of the [BRAINFRAME skills](https://github.com/The9thRealm/brainframe-skills) collection.

## Install (one line)

```bash
curl -fsSL https://raw.githubusercontent.com/The9thRealm/brainframe-qpulse/main/install.sh | bash
```

Installs to `~/.claude/skills/qpulse/` by default. Override the target with `SKILLS_DIR=...`.

## What you get

A boxed dashboard like:

```
╔══════════════════════════════════════════════════════════════╗
║  Q PULSE  ·  2026-05-30 11:10 PT                             ║
╚══════════════════════════════════════════════════════════════╝

── IN PROGRESS ──────────────────────────────────────────────────
### API-204 — Rate limiter
  ✅ token-bucket core
  ⏳ wiring middleware
  ☐ tests

── QUEUE (next 5 unblocked) ─────────────────────────────────────
1. API-205 — per-route overrides

── BLOCKED ──────────────────────────────────────────────────────
- API-206 — needs prod Redis URL from ops

── SERVICES / DAEMONS ───────────────────────────────────────────
api:     ✅ active
worker:  ❌ inactive
```

## Configure

On first run the skill helps you create a `qpulse.config.json` describing your task file,
optional nodes, and the read-only health checks for your services. See
[`SKILL.md`](SKILL.md) for the full schema and rendering rules.

## Adopting in other CLIs

`SKILL.md` is plain Markdown. Any agent that can read a system-prompt fragment can adopt it:
- **Claude Code** — installed automatically as a skill (above).
- **Other CLIs** — point your agent at `SKILL.md`, or paste its body into your rules/system
  prompt. The format and steps are tool-agnostic; only the host's task-list call differs.

## License

Public reference skill. Adopt freely; supply your own config.
