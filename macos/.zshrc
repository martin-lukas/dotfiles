# History — extended with timestamps
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY          # save timestamp + duration to history file
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY        # write immediately, not on shell exit

export PROMPT_EOL_MARK=''        # don't show % on partial lines

# Colors
export CLICOLOR=1

# Prompt with git branch
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats ' (%b)'
precmd() { vcs_info }
setopt PROMPT_SUBST
export PROMPT='%F{green}%n@%m%f %F{blue}%~%f%F{yellow}${vcs_info_msg_0_}%f %# '

# Shared aliases (compatible with zsh)
[ -f ~/dotfiles/common/.bash_aliases ] && source ~/dotfiles/common/.bash_aliases

# Machine-specific overrides (not tracked in git)
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
