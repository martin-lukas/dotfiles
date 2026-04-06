# Homebrew - Set PATH, MANPATH, etc.
eval "$(/opt/homebrew/bin/brew shellenv)"

# Custom local scripts
export PATH="$PATH:$HOME/.bin"
export PATH="$HOME/.local/bin:$PATH"

export ENABLE_CLAUDEAI_MCP_SERVERS=false

# Source .zshrc from login shells (mirrors how .bash_profile sources .bashrc)
[ -f ~/.zshrc ] && source ~/.zshrc

# Machine-specific overrides (not tracked in git)
if [ -f ~/.zprofile.local ]; then source ~/.zprofile.local; fi
