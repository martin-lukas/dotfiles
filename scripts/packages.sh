# Package installation.
# Sourced by bootstrap.sh — inherits DOTFILES, CONTEXT, pass/fail.

_installed() {
    command -v "$1" &>/dev/null
}

_pkg_install() {
    local pkg="$1" cmd="${2:-$1}"
    if _installed "$cmd"; then
        pass "$cmd (already installed)"
    else
        doing "Installing $pkg"
        if pkg install -y "$pkg" &>/dev/null; then
            pass "$cmd"
        else
            fail "$cmd — pkg install failed"
        fi
    fi
}

_apt_install() {
    local pkg="$1" cmd="${2:-$1}"
    if _installed "$cmd"; then
        pass "$cmd (already installed)"
    else
        doing "Installing $pkg"
        if sudo apt-get install -y "$pkg" &>/dev/null; then
            pass "$cmd"
        else
            fail "$cmd — apt install failed"
        fi
    fi
}

_brew_install() {
    local pkg="$1" cmd="${2:-$1}"
    if _installed "$cmd"; then
        pass "$cmd (already installed)"
    else
        doing "Installing $pkg"
        if brew install "$pkg" &>/dev/null; then
            pass "$cmd"
        else
            fail "$cmd — brew install failed"
        fi
    fi
}

_brew_cask_install() {
    local pkg="$1"
    if brew list --cask "$pkg" &>/dev/null; then
        pass "$pkg (already installed)"
    else
        doing "Installing $pkg (cask)"
        if brew install --cask "$pkg" &>/dev/null; then
            pass "$pkg"
        else
            fail "$pkg — brew cask install failed"
        fi
    fi
}

case "$CONTEXT" in
    termux)
        # pkg is Termux's package manager — no sudo needed
        doing "Updating packages (termux)"
        pkg update -y &>/dev/null
        pkg upgrade -y &>/dev/null
        _pkg_install vim
        _pkg_install tmux
        _pkg_install fzf
        _pkg_install tree
        _pkg_install ripgrep rg
        _pkg_install openssh ssh
        _pkg_install which
        _pkg_install build-essential gcc
        if [ -d ~/storage/shared ]; then
            pass "storage access granted"
        else
            fail "storage not set up — run 'termux-setup-storage' manually (triggers Android permission dialog)"
        fi
        ;;
    wsl|linux)
        doing "Updating apt package lists"
        sudo apt-get update -qq
        _apt_install vim
        _apt_install tmux
        _apt_install fzf
        _apt_install tree
        _apt_install ripgrep rg
        _apt_install build-essential gcc
        ;;
    macos)
        if ! _installed brew; then
            doing "Installing Homebrew"
            # HOMEBREW_NO_INTERACTIVE skips prompts; installer may attempt to modify
            # ~/.zprofile but will skip if the eval line already exists (it does in ours)
            NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" 2>/dev/null
            # Safety check: ensure installer didn't append anything to our dotfiles zprofile
            if grep -q "Added by Homebrew" "$DOTFILES/macos/.zprofile" 2>/dev/null; then
                sed -i '' '/Added by Homebrew/,/brew shellenv/d' "$DOTFILES/macos/.zprofile"
                fail "Homebrew installer modified macos/.zprofile — cleaned up, please review"
            else
                pass "Homebrew installed"
            fi
            eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            pass "Homebrew (already installed)"
        fi
        _brew_install vim
        _brew_install tmux
        _brew_install fzf
        _brew_install tree
        _brew_install ripgrep rg
        _brew_cask_install maccy
        # Xcode CLI tools provide compilers on macOS (replaces build-essential)
        if xcode-select -p &>/dev/null; then
            pass "Xcode CLI tools (already installed)"
        else
            doing "Installing Xcode CLI tools (follow the prompt)"
            if xcode-select --install 2>/dev/null; then
                pass "Xcode CLI tools"
            else
                fail "Xcode CLI tools — run 'xcode-select --install' manually"
            fi
        fi
        ;;
esac
