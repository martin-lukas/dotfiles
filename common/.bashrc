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
# Load git prompt if available
for _git_prompt in \
    /usr/share/git-core/contrib/completion/git-prompt.sh \
    /usr/lib/git-core/git-sh-prompt \
    /etc/bash_completion.d/git-prompt \
    /opt/homebrew/etc/bash_completion.d/git-prompt.sh \
    "$PREFIX/share/git/git-prompt.sh"; do
    [ -f "$_git_prompt" ] && { . "$_git_prompt"; break; }
done
unset _git_prompt

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1

# Fallback if git-prompt.sh wasn't found
if ! declare -f __git_ps1 > /dev/null; then
    __git_ps1() {
        local branch
        branch="$(git symbolic-ref --short HEAD 2>/dev/null)" || return
        printf "${1:- (%s)}" "$branch"
    }
fi

if [ -x /usr/bin/tput ] && tput setaf 1 &>/dev/null; then
    if [ -n "${TERMUX_VERSION:-}" ]; then
        PS1='\[\033[01;32m\]termux\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 " (%s)")\$ '
    else
        PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 " (%s)")\$ '
    fi
else
    PS1='\u@\h:\w$(__git_ps1 " (%s)")\$ '
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

# --- SSH agent ---
_SSH_ENV="$HOME/.ssh/agent-env"
_start_ssh_agent() {
    ssh-agent > "$_SSH_ENV"
    chmod 600 "$_SSH_ENV"
    . "$_SSH_ENV" > /dev/null
}
if [ -f "$_SSH_ENV" ]; then
    . "$_SSH_ENV" > /dev/null
    ssh-add -l &>/dev/null || _start_ssh_agent
else
    _start_ssh_agent
fi
unset _SSH_ENV

# --- Machine-specific overrides (not tracked in git) ---
[ -f ~/.bashrc.local ] && . ~/.bashrc.local
