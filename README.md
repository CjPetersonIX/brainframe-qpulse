# brainframe-qpulse

Portable skill: render a read-only **Q Pulse** — in progress, queue, blocked, services, this brain's CKPT.

Companion to [brainframe-handoff](https://github.com/CjPetersonIX/brainframe-handoff).  
Public wrapper skill — not the full BrainFrame OS / MasterQ implementation.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/CjPetersonIX/brainframe-qpulse/main/install.sh | bash
```

Default: `~/.claude/skills/qpulse/`.

## Cadence

| Command | Who | When | CKPT effect |
|---|---|---|---|
| `/qpulse` (this skill) | any seat on **this** brain | every 30–60 min, or on ask | `LOCAL` + 1 |
| network fold (`/masterq` or your hub) | one hub brain | ~24 h if you run a fleet | `MASTER` + 1, every brain `LOCAL` → `.00` |

A single LITE box only needs `/qpulse`. The fold exists when you sync multiple brains.

## Stamp on the pulse

```
<NODE-ID> CKPT <MASTER>.<LOCAL>
```

Same rules as the handoff skill: millidigit is a **counter**, not a float; all seats on this brain share it; publish the pulse file on `main`.

## Board

```
╔════════════════════════════════════════════════════════════╗
║  Q PULSE  ·  <date> <TZ>  ·  <NODE-ID> CKPT <M>.<L>      ║
╚════════════════════════════════════════════════════════════╝

── IN PROGRESS ─
── QUEUE ─
── BLOCKED ─
── SERVICES ─
── RAM / HEALTH (LITE boxes) ─
```

Config and rules: [`SKILL.md`](SKILL.md).

Public reference skill. Adopt freely.
