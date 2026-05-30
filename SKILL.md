---
name: qpulse
description: Render a single read-only status dashboard ("Q Pulse") of everything in flight — in-progress tasks with progress bars, the next queued items, blocked items, and daemon/service health. Invoke when the user asks "where do things stand", "status", "pulse", or wants a snapshot without re-explaining the format.
---

# Q Pulse — unified status dashboard

A **Q Pulse** is a compact, boxed, read-only snapshot of where all work stands right now.
One glance answers: what's in progress, what's next, what's blocked, and what's running.

This skill is **config-driven** — it reads a small project file describing *your* task
source, nodes, and services, then renders the standard format below. Nothing here is
specific to any one project.

## Configuration

On first use, look for a `qpulse.config.json` in the project root (or `.qpulse.json` in
the user's home). If it's missing, create one with the user from this template and ask
them to fill the blanks:

```json
{
  "task_source": "TASKS.md",
  "handoff_file": "handoff/LATEST.md",
  "nodes": [
    { "name": "<NODE_NAME>", "health_file": "nodes/<node>.json" }
  ],
  "services": [
    { "label": "<service-name>", "check": "<shell command that prints status>" }
  ],
  "blocked_marker": "BLOCKED"
}
```

- `task_source` — a markdown file whose `IN PROGRESS` / `QUEUE` sections drive the board.
- `services[].check` — any shell one-liner (e.g. `systemctl is-active foo`, `pgrep -f bar`)
  whose output reports up/down. Keep these **read-only**.
- `nodes` is optional — drop the section entirely for single-machine setups.

## Format

```
╔══════════════════════════════════════════════════════════════╗
║  Q PULSE  ·  <date> <time TZ>  ·  <checkpoint-id?>           ║
╚══════════════════════════════════════════════════════════════╝

── IN PROGRESS ──────────────────────────────────────────────────
### <TASK-ID> — <Title>
  ✅ <completed step>
  ⏳ <current step>
  ☐ <next step>
  ❌ <blocked step, if any>

── QUEUE (next 5 unblocked) ─────────────────────────────────────
1. <TASK-ID> — <what to do>
2. ...

── BLOCKED ──────────────────────────────────────────────────────
- <TASK-ID> — <what's needed to unblock, and from whom>

── SERVICES / DAEMONS ───────────────────────────────────────────
<label>:   <status ✅ / ❌>   <optional detail>

── NODES (omit if single-machine) ───────────────────────────────
<NODE_NAME> · <last-seen> · <uptime?>
  <key health lines from the node's health_file>
```

Legend: ✅ done · ⏳ in progress · ☐ not started · ❌ blocked.

## Steps

1. Load `qpulse.config.json` (create it with the user if absent).
2. Read `task_source`; extract the IN PROGRESS section and the queue.
3. If a `handoff_file` is configured, read it for any progress notes since the last pulse.
4. Call the host's task-list tool, if any, and fold in-session tasks into IN PROGRESS.
5. For each `services[].check`, run the command (read-only) and mark ✅/❌ from its output.
6. For each node, read its `health_file` and surface the key lines.
7. Print the dashboard in the exact format above — IN PROGRESS first, then QUEUE, BLOCKED,
   SERVICES, then NODES. Keep it tight; this is a glance, not a report.

## Don't

- Don't run anything that mutates state — no builds, deploys, fetches, or sends. Read-only.
- Don't list completed tasks; the board is about *active* work.
- Don't invent status. If a check fails or a file is missing, show `❓ unknown`, not a guess.
- Don't widen past ~64 columns — it must stay readable in a narrow terminal.

## Extend

If invoked as `qpulse --update`, after printing the board, append today's progress to the
configured `handoff_file` using the host project's checkpoint format (see the companion
`handoff` skill if installed).
