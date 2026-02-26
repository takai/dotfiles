# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A chezmoi-managed dotfiles repository for macOS. The repo lives at `~/.local/share/chezmoi` (symlinked from `~/src/local/dotfiles`).

## Key Commands

```sh
chezmoi apply              # Apply dotfiles to home directory
chezmoi diff               # Preview changes before applying
chezmoi update             # Pull latest and apply
chezmoi edit <target>      # Edit a managed file (opens source)
chezmoi cat <target>       # View rendered template output
chezmoi data               # Show template data (git.name, git.email, etc.)
```

## Chezmoi Conventions

- **Naming**: `dot_` prefix maps to `.`, `private_` marks files as 0600, `.tmpl` suffix enables Go templating
- **Templates**: Two files use chezmoi templates:
  - `dot_gitconfig.tmpl` — conditionally includes signing config based on `.git.signingkey` and `.git.format` from `~/.config/chezmoi/chezmoi.toml`
  - `dot_config/zsh/settings/platform.zsh.tmpl` — OS-specific aliases via `.chezmoi.os`
- **Ignore**: `.chezmoiignore` excludes `README.md` from being applied
- **No scripts**: No `run_once_*` or `run_onchange_*` scripts; tool setup is manual via `mise install`

## Architecture

**Shell (zsh)**: `dot_zshrc` is a single-line entry that sources sheldon. All config is modular under `dot_config/zsh/`:
- `settings/` — loaded by sheldon as a local plugin (config, history, path, platform, keybindings)
- `functions/` — ghq repo navigation (`repo.zsh`), Claude plans browser (`plans.zsh`)
- `completions/` — pre-generated completions for chezmoi, mairu, mise, sheldon

**Sheldon** (`dot_config/sheldon/plugins.toml`): Zsh plugin manager with deferred loading. Loads community plugins + local paths (`~/.config/zsh/settings`, `~/.config/zsh/completions`).

**Mise** (`dot_config/mise/config.toml`): Manages tool versions (Ruby, Go) and Go-based CLI tools (git-ai-commit, ghq, fzf, etc.). `GOPRIVATE=github.com/takai/*`.

**Git** (`dot_gitconfig.tmpl`): Templated config with conditional SSH/GPG signing. Includes `~/.gitconfig.local` for machine-local overrides. Uses `merge.ff = only` and `push.default = current`.

**Emacs** (`private_dot_emacs.d/init.el`): Marked private. Uses MELPA Stable, configures ddskk (Japanese input) and platform-specific fonts.

## Template Data

Chezmoi template variables come from `~/.config/chezmoi/chezmoi.toml`:
```toml
[data.git]
  name = "..."
  email = "..."
  signingkey = "..."    # optional; enables commit signing
  format = "ssh"        # optional; "ssh" enables SSH signing config
```

## Adding New Dotfiles

```sh
chezmoi add ~/.some/config        # Add as plain file
chezmoi add --template ~/.some/config  # Add as template
```

For new zsh settings, add a `.zsh` file to `dot_config/zsh/settings/` — sheldon picks it up automatically via the local plugin path.
