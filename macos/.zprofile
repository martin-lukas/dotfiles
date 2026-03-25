# Homebrew - Set PATH, MANPATH, etc.
eval "$(/opt/homebrew/bin/brew shellenv)"

# Custom local scripts
export PATH="$PATH:$HOME/.bin"

# Machine-specific overrides (not tracked in git)
[ -f ~/.zprofile.local ] && source ~/.zprofile.local
