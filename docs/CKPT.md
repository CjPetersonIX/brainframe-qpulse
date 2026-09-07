# CKPT · Q Pulse · MasterQ

## Stamp

```
<NODE-ID> CKPT <MASTER>.<LOCAL>
           └─ XXXX     └─ xxx   (millidigit — a COUNTER)
```

Examples:

```
MAC-01   CKPT 5289.007
MAC-02   CKPT 5289.041
OCI-01   CKPT 5289.159
HOME-01  CKPT    1.003    ← standalone, no network yet
```

`5289.007` is **7** updates this epoch, not "5289 and 7 thousandths".
`5289.159` is **159** updates. **Never float-compare** (`.020` vs `.159` reverses if you do).
Compare `(int(master), int(local))`.

Pad `LOCAL` to 3 digits in public text (`.007`, `.041`, `.159`). The value is still an integer. It may grow past 999.

One millidigit **per brain**. Every seat on that box adds +1 to the same counter. No private `.001` because you are VP3.

## Two jobs

| Job | Who | When | What happens to the stamp |
|---|---|---|---|
| **Q Pulse** (`/qpulse`) | any seat on **this** brain | 30–60 min, or on ask | `LOCAL + 1`. File: `comms/qpulse/<NODE>-QPULSE.md` on `main` |
| **MasterQ** (fold) | R1 CommHub / owner-named hub only | ~24 h on a network | read every brain pulse → write MasterQ → `MASTER + 1` → every brain `LOCAL → .000` |

A single wrapper box only needs Q Pulse. MasterQ exists when **two or more brains** share an epoch.

## Fold (Q → MasterQ)

```text
brain A  5289.007   comms/qpulse/A-QPULSE.md
brain B  5289.041   comms/qpulse/B-QPULSE.md
brain C  (silent)
        │
        │  hub reads main, not a feature branch
        ▼
MasterQ  comms/Q-PULSE.md     epoch 5289 summary
        │
        │  MASTER 5289 → 5290
        │  A,B,C LOCAL reset .000
        ▼
next Q   A CKPT 5290.001
```

Rules at fold:

1. Read each `comms/qpulse/<NODE>-QPULSE.md` from **`main`**.
2. Merge into `comms/Q-PULSE.md` (the MasterQ). Rewrite the register from current pulses — do not append a diary forever.
3. A brain that did not report is **named as missing**, not skipped.
4. Same epoch, two stories: higher millidigit is later work. Real contradiction: record **both**, flag R0. Do not silently pick.
5. Then `MASTER += 1`. Every reporting brain starts the new epoch at `.000` (first pulse `.001`).

Disconnected brains keep incrementing locally (`5289.043`, …). That millidigit is the receipt. Nothing is discarded because they were offline. They merge at the **next** fold.

This skill (`qpulse`) does **not** bump `MASTER`. Only the hub fold does.
