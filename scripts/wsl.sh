# WSL-specific setup.
# Sourced by install.sh — inherits DOTFILES, CONTEXT, pass/skip/fail.

if sudo cp "$DOTFILES/wsl/wsl.conf" /etc/wsl.conf 2>/dev/null; then
    pass "wsl.conf installed (run 'wsl --shutdown' from PowerShell to apply)"
else
    fail "wsl.conf — sudo required: run 'sudo cp $DOTFILES/wsl/wsl.conf /etc/wsl.conf'"
fi
