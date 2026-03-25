# ~/.bashrc — interactive bash config (WSL + Linux)

# Early exit for non-interactive shells
case $- in *i*) ;; *) return;; esac

# --- History ---
HISTCONTROL=ignoreboth              # ignore duplicates + lines starting with space
HISTSIZE=1000000
HISTFILESIZE=1000000
HISTTIMEFORMAT="%F %T "             # timestamp every command: 2026-03-25 21:05:33
shopt -s histappend                 # append to history file, don't overwrite
# Write each command to history immediately (not on shell exit)
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND; }history -a"

# --- Terminal ---
shopt -s checkwinsize               # update LINES/COLUMNS after each command

# --- Color prompt ---
if [ -x /usr/bin/tput ] && tput setaf 1 &>/dev/null; then
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='\u@\h:\w\$ '
fi

# --- Colors ---
if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b)"
fi
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'

# --- PATH & editor ---
export PATH="$HOME/.local/bin:$PATH"
export EDITOR=$(command -v vim || command -v vi)

# --- Bash completion ---
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# --- Shared aliases ---
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# --- WSL-specific ---
if grep -qi microsoft /proc/version 2>/dev/null; then
    alias cdc='cd /mnt/c'
    alias cdw='cd /mnt/c/Users/mail'
    alias cdd='cd /mnt/c/Users/mail/Desktop'
fi

# --- Machine-specific overrides (not tracked in git) ---
[ -f ~/.bashrc.local ] && . ~/.bashrc.local
