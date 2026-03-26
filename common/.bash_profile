# ~/.bash_profile — login shell entry point (SSH, TTY login)
# Bash reads this instead of .bashrc for login shells, so we source .bashrc
# explicitly. This is needed on NixOS and any distro that doesn't do it for us.
[ -f ~/.bashrc ] && . ~/.bashrc
