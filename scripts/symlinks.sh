# Symlink all dotfiles into place.
# Sourced by install.sh — inherits DOTFILES, CONTEXT, pass/skip/fail.

_symlink() {
    local src="$1" dst="$2" label="$3"
    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        doing "Backing up existing $label to ${dst}.local"
        mv "$dst" "${dst}.local"
    fi
    if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
        pass "$label"
    else
        doing "Symlinking $label"
        ln -sf "$src" "$dst"
        pass "$label"
    fi
}

# Common — all platforms
_symlink "$DOTFILES/common/.bash_aliases" ~/.bash_aliases ".bash_aliases"
_symlink "$DOTFILES/common/.gitconfig"    ~/.gitconfig    ".gitconfig"
_symlink "$DOTFILES/common/.vimrc"        ~/.vimrc        ".vimrc"
_symlink "$DOTFILES/common/.tmux.conf"    ~/.tmux.conf    ".tmux.conf"

if [ "${SKIP_SSH:-false}" = false ]; then
    mkdir -p ~/.ssh && chmod 700 ~/.ssh
    chmod 600 "$DOTFILES/common/.ssh/config"
    _symlink "$DOTFILES/common/.ssh/config" ~/.ssh/config "~/.ssh/config"
else
    pass "~/.ssh/config (skipped)"
fi

# Scripts
mkdir -p ~/.local/bin
_symlink "$DOTFILES/bin/hs" ~/.local/bin/hs "~/.local/bin/hs"

# Context-specific
case "$CONTEXT" in
    wsl|linux|nixos|termux)
        _symlink "$DOTFILES/common/.bashrc"       ~/.bashrc       ".bashrc"
        _symlink "$DOTFILES/common/.bash_profile" ~/.bash_profile ".bash_profile"
        if [[ "$CONTEXT" == "termux" ]]; then
            mkdir -p ~/.termux
            _symlink "$DOTFILES/termux/termux.properties" ~/.termux/termux.properties "termux.properties"
            doing "Reloading termux settings"
            termux-reload-settings && pass "termux settings reloaded" || fail "termux-reload-settings failed"
        fi
        ;;
    macos)
        _symlink "$DOTFILES/macos/.zprofile" ~/.zprofile ".zprofile"
        _symlink "$DOTFILES/macos/.zshrc"    ~/.zshrc    ".zshrc"
        ;;
esac
