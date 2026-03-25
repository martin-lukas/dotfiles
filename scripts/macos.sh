# macOS system preferences.
# Sourced by bootstrap.sh — inherits DOTFILES, CONTEXT, pass/fail.

# Show hidden files in Finder
if defaults write com.apple.Finder AppleShowAllFiles true 2>/dev/null; then
    pass "Finder: show hidden files"
else
    fail "Finder: show hidden files — defaults write failed"
fi

# Prevent Apple Music from launching on media key press
if launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2>/dev/null; then
    pass "Apple Music: disabled auto-launch"
else
    # Already unloaded or not present — not a real failure
    pass "Apple Music: auto-launch already disabled"
fi
