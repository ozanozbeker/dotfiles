# dotfiles

My dotfiles, managed with [chezmoi](https://www.chezmoi.io/).

## Use it

```sh
brew install chezmoi
gh repo clone ozanozbeker/dotfiles ~/dev/dotfiles
printf 'sourceDir = "~/dev/dotfiles"\n' > ~/.config/chezmoi/chezmoi.toml
chezmoi apply
brew bundle install --global
```

`chezmoi add <file>` copies a file into the repo, `chezmoi diff` shows what `apply` would change, and `chezmoi managed` lists what the repo owns.

## Layout

`.chezmoiignore` names the repo's own files, so chezmoi never writes them into `~`.
Everything else is a target, in chezmoi's naming: `dot_claude/CLAUDE.md` is `~/.claude/CLAUDE.md`.
`dot_config/homebrew/Brewfile` is `~/.config/homebrew/Brewfile`, which `brew bundle --global` reads once `.zshrc` sets `XDG_CONFIG_HOME`; `brew bundle dump --global --force --no-uv` rewrites it from what is installed, and it applies on macOS only.

VS Code's `settings.json` lives in a different directory per OS, so its body sits in `.chezmoitemplates/vscode/settings.jsonc` and a one-line template at each OS path includes it; `.chezmoiignore` keeps the other two paths off a machine.
Settings Sync is off, so the repo owns the settings and the `vscode` lines in the Brewfile own the extensions.
No VS Code state is tracked: `globalStorage`, `workspaceStorage` and `History` stay local.

The hooks come from the `none` answer of [templates](https://github.com/ozanozbeker/templates), without its workflows: nothing runs on GitHub.
