---
name: qpulse
description: Render a read-only Q Pulse dashboard for this brain. Header includes <NODE-ID> CKPT <MASTER>.<LOCAL>. Invoke on status/pulse/where do things stand, and every 30-60 minutes on a live node.
---

# Q Pulse — this brain's heartbeat

Read-only snapshot. Not MasterQ. MasterQ (network fold) is a different job on a hub brain.

## Stamp

Header must include:

```
<NODE-ID> CKPT <MASTER>.<LOCAL>
```

- Same numbering as the handoff skill.
- Each `/qpulse` on this brain does `LOCAL = high-water + 1`.
- Seats on this brain share `LOCAL`. No per-VP counter.
- `MASTER` changes only when a hub fold runs. This skill does not bump the epoch.
- Millidigit is a counter. Never float-compare.
- Write `comms/qpulse/<NODE>-QPULSE.md` (or the path in config) on **`main`**.

## Configuration

`qpulse.config.json` at project root (or `~/.qpulse.json`):

```json
{
  "node_id": "HOME-01",
  "task_source": "TASK_QUEUE.md",
  "handoff_file": "handoff/LATEST_HANDOFF.txt",
  "pulse_file": "comms/qpulse/HOME-01-QPULSE.md",
  "services": [
    { "label": "<service>", "check": "<read-only shell>" }
  ],
  "blocked_marker": "BLOCKED"
}
```

Create it with the user if missing.

## Format

```
Q PULSE  ·  <date> <TZ>  ·  <NODE-ID> CKPT <MASTER>.<LOCAL>

── IN PROGRESS ─
### <TASK-ID> — <Title>
  ✅ …
  ⏳ …
  ☐ …

── QUEUE (next 5 unblocked) ─
1. …

── BLOCKED ─
- <TASK-ID> — needs <who/what>

── SERVICES / DAEMONS ─
<label>: ✅ / ❌ / ❓

── RAM / HEALTH ─
<used/total if known>  hook: ✅/❌
```

## Steps

1. Load config. Read last pulse for high-water `LOCAL`.
2. Read task source + handoff tip.
3. Run service checks read-only.
4. Print the board with the new stamp (`LOCAL+1`).
5. If the user wants it persisted, write `pulse_file` on `main`.
6. Optional `--update`: also refresh the handoff using the handoff skill.

## Don't

- Mutate the world (no deploys, sends, builds) from a pulse.
- List ancient completed work.
- Invent health.
- Call this MasterQ.
- Hide the pulse on a feature branch.
