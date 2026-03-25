# Dotfiles

Personal dotfiles for macOS, WSL, and Linux. Covers shell, editor, git, and SSH config.

## Fresh install

```bash
sudo apt install git -y   # or: brew install git
git clone git@github.com:martin-lukas/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./install.sh
```

## Related

- [martin-lukas/claude](https://github.com/martin-lukas/claude) — Claude Code config (`settings.json`, statusline). Run its `install.sh` separately after this one.
- [Tailscale](https://tailscale.com/download) — install and log in via GitHub to access the homeserver.
