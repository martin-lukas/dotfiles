# dotfiles

Personal dotfiles repo for macOS, WSL, and Linux (NixOS home server).

## Structure

- `common/` — shared configs for all platforms (.bashrc, .bash_aliases, .gitconfig, .vimrc, .ssh/config)
- `macos/` — macOS-specific (.zprofile, .zshrc)
- `wsl/` — WSL-specific (wsl.conf)
- `scripts/` — modular install scripts (symlinks.sh, github.sh, wsl.sh, packages.sh, macos.sh)
- `install.sh` — coordinator for symlinking + GitHub SSH setup; detects context, prints summary
- `bootstrap.sh` — coordinator for package installs + macOS preferences; detects context, prints summary
