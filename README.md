# Dotfiles

Personal dotfiles for macOS, WSL, and Linux. Covers shell, editor, git, and SSH config.

## Fresh install

```bash
sudo apt install git -y   # or: brew install git
git clone git@github.com:martin-lukas/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./install.sh
```

## Machine-specific overrides

These files are sourced automatically but not tracked in git — create them on each machine as needed:

| File                  | Used by                                                       |
|-----------------------|---------------------------------------------------------------|
| `~/.bashrc.local`     | bash (WSL, Linux) — covers both interactive and login shells  |
| `~/.zshrc.local`      | zsh interactive shell (macOS)                                 |
| `~/.zprofile.local`   | zsh login shell (macOS)                                       |
| `~/.ssh/config.local` | SSH (all platforms)                                           |

Use these for machine-specific PATH additions, credentials, and tool configs (Docker, Python versions, VS Code, Coursier, etc.).

## Related

- [martin-lukas/claude](https://github.com/martin-lukas/claude) — Claude Code config (`settings.json`, statusline). Run its `install.sh` separately after this one.
- [Tailscale](https://tailscale.com/download) — install and log in via GitHub to access the homeserver.
