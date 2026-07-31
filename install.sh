#!/usr/bin/env bash
#
# brainframe-qpulse — installer
#
#   curl -fsSL https://raw.githubusercontent.com/CjPetersonIX/brainframe-qpulse/main/install.sh | bash
#
# Installs the Q Pulse skill into your agent's skills directory. Non-interactive,
# idempotent. Defaults to Claude Code (~/.claude/skills); override with SKILLS_DIR.
#
set -euo pipefail

SKILL="qpulse"
REPO_RAW="https://raw.githubusercontent.com/CjPetersonIX/brainframe-qpulse/main"
SKILLS_DIR="${SKILLS_DIR:-$HOME/.claude/skills}"
DEST="$SKILLS_DIR/$SKILL"

c_ok()   { printf '\033[92m  ✓\033[0m %s\n' "$1"; }
c_step() { printf '\033[96m▸ %s\033[0m\n' "$1"; }

c_step "Installing $SKILL → $DEST"
mkdir -p "$DEST"

# Prefer a local checkout (bundle install / git clone); fall back to fetching raw.
SRC_DIR="$(cd "$(dirname "$0")" && pwd)"
if [ -f "$SRC_DIR/SKILL.md" ]; then
  cp "$SRC_DIR/SKILL.md" "$DEST/SKILL.md"
  [ -f "$SRC_DIR/VERSION" ] && cp "$SRC_DIR/VERSION" "$DEST/VERSION"
  c_ok "copied from local checkout"
else
  curl -fsSL "$REPO_RAW/SKILL.md" -o "$DEST/SKILL.md"
  curl -fsSL "$REPO_RAW/VERSION" -o "$DEST/VERSION" 2>/dev/null || true
  c_ok "fetched from $REPO_RAW"
fi

printf '\033[92m%s installed.\033[0m  Invoke it by asking your agent for a "Q Pulse" or status.\n' "$SKILL"
echo "On first run it will help you create qpulse.config.json for your project."
