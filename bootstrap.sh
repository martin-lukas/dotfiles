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
elif [ -f /etc/os-release ] && grep -qi nixos /etc/os-release; then
    CONTEXT="nixos"
else
    CONTEXT="linux"
fi
export CONTEXT

# --- Guard: NixOS manages packages via configuration.nix ---
if [[ "$CONTEXT" == "nixos" ]]; then
    echo "NixOS detected — bootstrap is not supported. Manage packages via configuration.nix."
    exit 1
fi

# --- Run modules ---
. "$DOTFILES/scripts/packages.sh"
[[ "$CONTEXT" == "macos" ]] && . "$DOTFILES/scripts/macos.sh"

# --- Summary ---
echo ""
echo "========================================"
echo " dotfiles bootstrap — $CONTEXT"
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
