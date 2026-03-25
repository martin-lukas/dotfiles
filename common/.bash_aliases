# Navigation
alias ll='ls -alhF'
alias la='ls -A'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Safety prompts
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Machine-specific aliases (not tracked in git)
if [ -f ~/.bash_aliases.local ]; then . ~/.bash_aliases.local; fi
