---
name: qpulse
description: Render a read-only Q Pulse for this brain. Stamp is NODE CKPT MASTER.LOCAL (XXXX.xxx millidigit). Does not run MasterQ. Invoke on status/pulse or every 30-60 min.
---

# Q Pulse — this brain

Not MasterQ. Fold is documented in [docs/CKPT.md](docs/CKPT.md).

## Stamp

```
<NODE-ID> CKPT <MASTER>.<LOCAL>
MAC-01 CKPT 5289.007
```

`LOCAL` is a counter, pad to 3 digits in text (`.007` = 7). Never parse as a float. All seats on this brain share it. Each `/qpulse` does `LOCAL + 1`. `MASTER` only changes after a hub fold.

Write `comms/qpulse/<NODE>-QPULSE.md` on `main`.

## Board

```
Q PULSE  ·  <date TZ>  ·  <NODE-ID> CKPT <MASTER>.<LOCAL>

-- IN PROGRESS --
-- QUEUE --
-- BLOCKED --
-- SERVICES --
-- RAM / HEALTH --
```

## Don't

Call this MasterQ. Hide it on a feature branch. Float-sort millidigits. Restart `.001` per VP.
