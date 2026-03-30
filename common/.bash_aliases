# Colorized commands
alias diff='diff --color=auto'

# Navigation
alias ll='ls -alhF'
alias la='ls -A'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# tmux
alias ta='tmux attach -d'

# Machine-specific aliases (not tracked in git)
if [ -f ~/.bash_aliases.local ]; then . ~/.bash_aliases.local; fi
