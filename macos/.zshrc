# History — extended with timestamps
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY          # save timestamp + duration to history file
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY        # write immediately, not on shell exit

export PROMPT_EOL_MARK=''        # suppress the % marker shown on lines without a trailing newline

# Colors
export CLICOLOR=1

# Prompt with git branch
# vcs_info is zsh's built-in VCS integration — populates vcs_info_msg_0_ before each prompt
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats ' (%b)'
precmd() { vcs_info }
setopt PROMPT_SUBST
export PROMPT='%F{green}%n@%m%f:%F{blue}%~%f%F{yellow}${vcs_info_msg_0_}%f
%(?:%F{green}❯%f:%F{red}❯%f) '

# Shared aliases (compatible with zsh)
[ -f ~/dotfiles/common/.bash_aliases ] && source ~/dotfiles/common/.bash_aliases

# fzf (Ctrl+R history search, Ctrl+T file search, Alt+C cd)
if command -v fzf &>/dev/null; then
    eval "$(fzf --zsh)"
fi

# Machine-specific overrides (not tracked in git)
if [ -f ~/.zshrc.local ]; then source ~/.zshrc.local; fi
