# Package installation.
# Sourced by bootstrap.sh — inherits DOTFILES, CONTEXT, pass/fail.

_installed() {
    command -v "$1" &>/dev/null
}

_apt_install() {
    local pkg="$1" cmd="${2:-$1}"
    if _installed "$cmd"; then
        pass "$cmd (already installed)"
    elif sudo apt-get install -y "$pkg" &>/dev/null; then
        pass "$cmd"
    else
        fail "$cmd — apt install failed"
    fi
}

_brew_install() {
    local pkg="$1" cmd="${2:-$1}"
    if _installed "$cmd"; then
        pass "$cmd (already installed)"
    elif brew install "$pkg" &>/dev/null; then
        pass "$cmd"
    else
        fail "$cmd — brew install failed"
    fi
}

case "$CONTEXT" in
    wsl|linux)
        sudo apt-get update -qq
        _apt_install vim
        _apt_install fzf
        _apt_install tree
        _apt_install ripgrep rg
        _apt_install build-essential gcc
        ;;
    macos)
        if ! _installed brew; then
            fail "Homebrew not found — install from https://brew.sh first"
            return
        fi
        _brew_install vim
        _brew_install fzf
        _brew_install tree
        _brew_install ripgrep rg
        # Xcode CLI tools provide compilers on macOS (replaces build-essential)
        if xcode-select -p &>/dev/null; then
            pass "Xcode CLI tools (already installed)"
        else
            echo "    Installing Xcode CLI tools (follow the prompt)..."
            if xcode-select --install 2>/dev/null; then
                pass "Xcode CLI tools"
            else
                fail "Xcode CLI tools — run 'xcode-select --install' manually"
            fi
        fi
        ;;
    nixos)
        fail "NixOS detected — manage packages via configuration.nix or nix-env, not this script"
        ;;
esac
