# dotfiles

This repo is managed with `chezmoi` and uses `mise` for tool versions and
`sheldon` for zsh plugins.

## Requirements

- `chezmoi`
- `mise`
- `sheldon`
- `zsh`

Install via your package manager (for example `brew install chezmoi mise sheldon`).

## First-time setup

1) Initialize and apply the dotfiles:

```sh
chezmoi init --apply <repo-url>
```

2) Configure git identity for the template in `dot_gitconfig.tmpl`:

```sh
chezmoi data set git.name "Your Name"
chezmoi data set git.email "you@example.com"
```

3) Install tool versions from `mise`:

```sh
mise install
```

4) Check `sheldon` local plugin paths in
`~/.config/sheldon/plugins.toml`. The repo currently references:

- `~/.config/zsh/settings`
- `~/.config/zsh/completions`

Update those paths if your setup differs.

## Update later

```sh
chezmoi update
```
