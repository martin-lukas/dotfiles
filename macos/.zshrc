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

# Shared aliases (compatible with zsh)
[ -f ~/dotfiles/common/.bash_aliases ] && source ~/dotfiles/common/.bash_aliases
