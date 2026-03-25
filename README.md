# Dotfiles

Personal dotfiles for macOS, WSL, and Linux. Covers shell, editor, git, and SSH config.

## Fresh install

Run bootstrap before install — bootstrap installs the tools (openssh, vim, etc.) that install depends on.

**Step 1 — install git** (the only manual prerequisite):

| Platform    | Command                                          |
|-------------|--------------------------------------------------|
| Linux / WSL | `sudo apt install git -y`                        |
| macOS       | `brew install git` (or it's pre-installed)       |
| Termux      | `pkg install git -y`                             |

**Step 2 — clone over HTTPS** (no SSH key needed yet):

```bash
git clone https://github.com/martin-lukas/dotfiles.git ~/dotfiles
```

**Step 3 — bootstrap** (installs packages):

```bash
# Termux only: pick a nearby mirror first
termux-change-repo

bash bootstrap.sh
```

**Step 4 — install** (symlinks dotfiles):

```bash
bash install.sh
```

If `~/.ssh/github` doesn't exist yet, install.sh will flag it as incomplete. Add your GitHub SSH private key there and rerun — it will verify GitHub auth and complete cleanly.

**Step 5 — switch remote to SSH**:

```bash
git remote set-url origin git@github.com:martin-lukas/dotfiles.git
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

## Manual steps (Termux)

- **Mirror selection** — run once before installing packages to pick a nearby mirror:
  ```bash
  termux-change-repo
  ```

## Manual steps (macOS)

Things not automated by `bootstrap.sh`:

- **VS Code key repeat** — if using VS Code, run once after install:
  ```bash
  defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
  ```

## Related

- [martin-lukas/claude](https://github.com/martin-lukas/claude) — Claude Code config (`settings.json`, statusline). Run its `install.sh` separately after this one.
- [Tailscale](https://tailscale.com/download) — install and log in via GitHub to access the homeserver.
