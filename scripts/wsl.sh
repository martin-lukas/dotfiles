# WSL-specific setup.
# Sourced by install.sh — inherits DOTFILES, CONTEXT, pass/skip/fail.

if diff -q "$DOTFILES/wsl/wsl.conf" /etc/wsl.conf &>/dev/null; then
    pass "wsl.conf"
else
    doing "Installing wsl.conf"
    if sudo cp "$DOTFILES/wsl/wsl.conf" /etc/wsl.conf 2>/dev/null; then
        pass "wsl.conf installed (run 'wsl --shutdown' from PowerShell to apply)"
    else
        fail "wsl.conf — sudo required: run 'sudo cp $DOTFILES/wsl/wsl.conf /etc/wsl.conf'"
    fi
fi
