# Homebrew - Set PATH, MANPATH, etc.
eval "$(/opt/homebrew/bin/brew shellenv)"

# Custom local scripts
export PATH="$PATH:$HOME/.bin"
export PATH="$HOME/.local/bin:$PATH"

# Machine-specific overrides (not tracked in git)
if [ -f ~/.zprofile.local ]; then source ~/.zprofile.local; fi
