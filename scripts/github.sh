# GitHub SSH setup: key permissions and connectivity check.
# Sourced by install.sh — inherits DOTFILES, CONTEXT, pass/skip/fail.

if [ ! -f ~/.ssh/github ]; then
    fail "GitHub SSH key missing — add private key to ~/.ssh/github, then rerun"
    return
fi

CURRENT_PERMS="$(stat -c '%a' ~/.ssh/github 2>/dev/null || stat -f '%A' ~/.ssh/github 2>/dev/null)"
if [ "$CURRENT_PERMS" != "600" ]; then
    doing "Setting GitHub SSH key permissions"
    chmod 600 ~/.ssh/github
fi
pass "GitHub SSH key found"

# Test GitHub connectivity
doing "Testing GitHub SSH connectivity"
AUTH_RESULT="$(ssh -T git@github.com -o StrictHostKeyChecking=accept-new 2>&1 || true)"
if echo "$AUTH_RESULT" | grep -q "successfully authenticated"; then
    pass "GitHub SSH auth verified"
else
    fail "GitHub SSH connection failed — key may not be added to GitHub yet"
    echo "    Add this public key to https://github.com/settings/ssh/new :"
    echo "    $(cat ~/.ssh/github.pub)"
fi
