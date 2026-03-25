#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

detect_context() {
    if grep -qi microsoft /proc/version 2>/dev/null; then echo "wsl"
    elif [[ "$OSTYPE" == "darwin"* ]];                  then echo "macos"
    else                                                      echo "linux"
    fi
}

CONTEXT=$(detect_context)
echo "==> Detected: $CONTEXT"

# Always — common configs
ln -sf "$DOTFILES/common/.gitconfig"    ~/.gitconfig
ln -sf "$DOTFILES/common/.vimrc"        ~/.vimrc
ln -sf "$DOTFILES/common/.bash_aliases" ~/.bash_aliases

case "$CONTEXT" in
    wsl|linux)
        ln -sf "$DOTFILES/common/.bashrc" ~/.bashrc
        if [[ "$CONTEXT" == "wsl" ]]; then
            sudo cp "$DOTFILES/wsl/wsl.conf" /etc/wsl.conf
            echo "    wsl.conf installed — run 'wsl --shutdown' from PowerShell to apply"
        fi
        ;;
    macos)
        ln -sf "$DOTFILES/macos/.zprofile" ~/.zprofile
        ln -sf "$DOTFILES/macos/.zshrc"    ~/.zshrc
        ;;
esac

echo "==> Done ($CONTEXT)"
