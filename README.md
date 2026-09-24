# brainframe-qpulse

Portable Q Pulse skill. Not MasterQ. Not BrainFrame OS.


## Relation to BrainFrame OS (first glance)

1. **This repo is NOT the fleet OS.** Portable Q Pulse skill only — not MasterQ.
2. **Fleet live truth** = [BrainframeOS README](https://github.com/CjPetersonIX/BrainframeOS/blob/main/README.md) + [`docs/ops/2026-09-23_t786u_FIRST_GLANCE_CURRENT_STATE.md`](https://github.com/CjPetersonIX/BrainframeOS/blob/main/docs/ops/2026-09-23_t786u_FIRST_GLANCE_CURRENT_STATE.md).
3. **CKPT format:** `<NODE-ID> CKPT <MASTER>.<LOCAL>` · current fleet epoch tip **5291 OPEN** (5292 VOID).
4. **MasterQ / map / rules:** MasterQ [`comms/Q-PULSE.md`](https://github.com/CjPetersonIX/BrainframeOS/blob/main/comms/Q-PULSE.md) on BrainframeOS. Local brains update own `comms/qpulse/*`; only Frontal merges MasterQ.

---

Header: `<NODE-ID> CKPT <MASTER>.<LOCAL>`

```bash
curl -fsSL https://raw.githubusercontent.com/CjPetersonIX/brainframe-qpulse/main/install.sh | bash
```

Bundle: [brainframe-skills](https://github.com/CjPetersonIX/brainframe-skills)  
Wrappers: [LITE](https://github.com/CjPetersonIX/Brainframe-litebrain-wrapper) · [FULL](https://github.com/CjPetersonIX/Brainframe-fullbrain-wrapper)  
Handoff: [brainframe-handoff](https://github.com/CjPetersonIX/brainframe-handoff)

[`SKILL.md`](SKILL.md)
