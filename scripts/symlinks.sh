# Symlink all dotfiles into place.
# Sourced by install.sh — inherits DOTFILES, CONTEXT, pass/skip/fail.

_symlink() {
    local src="$1" dst="$2" label="$3"
    if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
        skip "$label (already linked)"
    elif [ -e "$dst" ] && [ ! -L "$dst" ]; then
        fail "$label — real file exists at $dst, remove it to allow symlinking"
    else
        ln -sf "$src" "$dst"
        pass "$label"
    fi
}

# Common — all platforms
_symlink "$DOTFILES/common/.gitconfig"    ~/.gitconfig    ".gitconfig"
_symlink "$DOTFILES/common/.vimrc"        ~/.vimrc        ".vimrc"
_symlink "$DOTFILES/common/.bash_aliases" ~/.bash_aliases ".bash_aliases"

mkdir -p ~/.ssh && chmod 700 ~/.ssh
chmod 600 "$DOTFILES/common/.ssh/config"
_symlink "$DOTFILES/common/.ssh/config"   ~/.ssh/config   "~/.ssh/config"

# Context-specific
case "$CONTEXT" in
    wsl|linux)
        _symlink "$DOTFILES/common/.bashrc" ~/.bashrc ".bashrc"
        ;;
    macos)
        _symlink "$DOTFILES/macos/.zprofile" ~/.zprofile ".zprofile"
        _symlink "$DOTFILES/macos/.zshrc"    ~/.zshrc    ".zshrc"
        ;;
esac
