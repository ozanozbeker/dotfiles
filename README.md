# dotfiles

My dotfiles, managed with [chezmoi](https://www.chezmoi.io/).

## Use it

```sh
brew install chezmoi
gh repo clone ozanozbeker/dotfiles ~/dev/dotfiles
printf 'sourceDir = "~/dev/dotfiles"\n' > ~/.config/chezmoi/chezmoi.toml
chezmoi apply
```

`chezmoi add <file>` copies a file into the repo, `chezmoi diff` shows what `apply` would change, and `chezmoi managed` lists what the repo owns.

## Layout

`.chezmoiignore` names the repo's own files, so chezmoi never writes them into `~`.
Everything else is a target, in chezmoi's naming: `dot_claude/CLAUDE.md` is `~/.claude/CLAUDE.md`.

The hooks come from the `none` answer of [templates](https://github.com/ozanozbeker/templates), without its workflows: nothing runs on GitHub.
