# dotfiles

Personal dotfiles repo for macOS, WSL, and Linux (NixOS home server).

## Structure

- `common/` — shared configs for all platforms (.bashrc, .bash_aliases, .gitconfig, .vimrc, .ssh/config)
- `macos/` — macOS-specific (.zprofile, .zshrc)
- `wsl/` — WSL-specific (wsl.conf)
- `scripts/` — modular install scripts (symlinks.sh, github.sh, wsl.sh)
- `install.sh` — coordinator: detects context, runs scripts, prints summary

## Git

- Do not suggest committing unprompted — the user will ask when ready
- When the user requests a commit, write the commit message and run the command as usual
- Do not append `Co-Authored-By` or any other signature to commit messages
