# ~/.bashrc — interactive bash config (WSL, Linux, Termux)

# Skip entirely for non-interactive shells (e.g. scp, scripts)
case $- in *i*) ;; *) return;; esac

# --- History ---
HISTCONTROL=ignoreboth              # ignore duplicates + lines starting with space
HISTSIZE=1000000
HISTFILESIZE=1000000
HISTTIMEFORMAT="%F %T "             # timestamp every entry: 2026-03-25 21:05:33
shopt -s histappend                 # append to history file instead of overwriting
# Flush each command to history immediately so it's available in other sessions
PROMPT_COMMAND='__exit_code=$?; history -a; history -n'
bind 'set enable-bracketed-paste off'  # bracketed paste silently drops pasted commands from history

# --- Terminal ---
shopt -s checkwinsize               # recheck terminal size after each command, keeps LINES/COLUMNS accurate

# Disable terminal flow control (Ctrl-S/Ctrl-Q) and suspend signals (Ctrl-Z/Ctrl-Y)
stty -ixon                          # disable Ctrl-S (pause) and Ctrl-Q (resume)
stty susp undef                     # disable Ctrl-Z (suspend)

# --- Color prompt ---
# Try to source git-prompt.sh, which provides __git_ps1 for branch display in prompt.
# Check all known locations across Linux distros, Homebrew (macOS), and Termux.
for _git_prompt in \
    /usr/share/git-core/contrib/completion/git-prompt.sh \
    /usr/lib/git-core/git-sh-prompt \
    /etc/bash_completion.d/git-prompt \
    /opt/homebrew/etc/bash_completion.d/git-prompt.sh \
    "$PREFIX/share/git/git-prompt.sh"; do
    [ -f "$_git_prompt" ] && { . "$_git_prompt"; break; }
done
unset _git_prompt

GIT_PS1_SHOWDIRTYSTATE=1            # show * for unstaged, + for staged changes
GIT_PS1_SHOWUNTRACKEDFILES=1        # show % when untracked files are present

# Minimal fallback __git_ps1 if git-prompt.sh wasn't found (e.g. Termux)
if ! declare -f __git_ps1 > /dev/null; then
    __git_ps1() {
        local branch
        branch="$(git symbolic-ref --short HEAD 2>/dev/null)" || return
        printf "${1:- (%s)}" "$branch"
    }
fi

# Prompt symbol: green ❯ on success, red ❯ on failure
__prompt_symbol() {
    if [ "${__exit_code:-0}" -eq 0 ]; then
        printf '\001\033[01;32m\002❯\001\033[00m\002'
    else
        printf '\001\033[01;31m\002❯\001\033[00m\002'
    fi
}

# tput setaf 1: test whether the terminal supports ANSI colors (exit 0 if yes)
if tput setaf 1 &>/dev/null; then
    if [ -n "${TERMUX_VERSION:-}" ]; then
        # Termux: replace unreadable Android user/hostname with 'termux'
        PS1='\[\033[01;32m\]termux\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;33m\]$(__git_ps1 " (%s)")\[\033[00m\]\n$(__prompt_symbol) '
    else
        PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;33m\]$(__git_ps1 " (%s)")\[\033[00m\]\n$(__prompt_symbol) '
    fi
else
    PS1='\u@\h:\w$(__git_ps1 " (%s)")\n❯ '
fi

# --- Colors ---
# dircolors sets LS_COLORS so ls/grep/etc. use colored output
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
export ENABLE_CLAUDEAI_MCP_SERVERS=false

# --- systemd pager ---
# Remove 'S' (chop long lines) from less flags so journalctl/systemctl output wraps
export SYSTEMD_LESS=FRXMK

# --- Bash completion ---
# Enable tab-completion for commands, flags, and arguments
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

# --- fzf (Ctrl+R history search, Ctrl+T file search, Alt+C cd) ---
if command -v fzf &>/dev/null; then
    eval "$(fzf --bash)"
fi

# --- Machine-specific overrides (not tracked in git) ---
if [ -f ~/.bashrc.local ]; then . ~/.bashrc.local; fi
