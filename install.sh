#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export DOTFILES

# --- Status tracking (shared with all scripts) ---
declare -a OK=()
declare -a FAIL=()

pass()  { OK+=("  [✓] $1"); }
fail()  { FAIL+=("  [!] $1"); }
doing() { echo "  $1..."; }

export -f pass fail doing

# --- Context detection ---
if [ -n "${TERMUX_VERSION:-}" ]; then
    CONTEXT="termux"
elif grep -qi microsoft /proc/version 2>/dev/null; then
    CONTEXT="wsl"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    CONTEXT="macos"
else
    CONTEXT="linux"
fi
export CONTEXT

# --- Run modules ---
. "$DOTFILES/scripts/symlinks.sh"
. "$DOTFILES/scripts/github.sh"
[[ "$CONTEXT" == "wsl" ]] && . "$DOTFILES/scripts/wsl.sh"

# --- Summary ---
echo ""
echo "========================================"
echo " dotfiles install — $CONTEXT"
echo "========================================"
for msg in "${OK[@]:-}";   do echo "$msg"; done
for msg in "${FAIL[@]:-}"; do echo "$msg"; done
echo ""
if [ ${#FAIL[@]} -eq 0 ]; then
    echo " All done!"
else
    echo " ${#FAIL[@]} item(s) need attention (see [!] above)"
fi
echo "========================================"
