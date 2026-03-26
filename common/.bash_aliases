# Navigation
alias ll='ls -alhF'
alias la='ls -A'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Machine-specific aliases (not tracked in git)
if [ -f ~/.bash_aliases.local ]; then . ~/.bash_aliases.local; fi
