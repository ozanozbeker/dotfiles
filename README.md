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

Claude Code writes `~/.claude/settings.json` itself, so the repo does not track it.
The plugins and skills come back with:

```sh
for m in mattpocock/skills dagster-io/skills polars-inc/skills dbt-labs/dbt-agent-skills ozanozbeker/skills; do claude plugin marketplace add "$m"; done
for p in polars@polars dagster-expert@dagster mattpocock-skills@mattpocock dbt@dbt-agent-marketplace ozanozbeker-skills@ozanozbeker; do claude plugin install "$p"; done
for s in quantco/dataframely@dataframely j178/prek@prek github/awesome-copilot@github-actions-efficiency github/awesome-copilot@github-actions-hardening tt-a1i/archify@archify vercel-labs/skills@find-skills; do npx -y skills add "$s" -g -a claude-code --copy -y; done
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.ozanozbeker.skills-update.plist
```

The last line loads the agent that runs `npx skills update -g` at 06:00 each day.

`chezmoi add <file>` copies a file into the repo, `chezmoi diff` shows what `apply` would change, and `chezmoi managed` lists what the repo owns.

## Layout

`.chezmoiignore` names the repo's own files, so chezmoi never writes them into `~`.
Everything else is a target, in chezmoi's naming: `dot_claude/CLAUDE.md` is `~/.claude/CLAUDE.md`.
`dot_config/homebrew/Brewfile` is `~/.config/homebrew/Brewfile`, which `brew bundle --global` reads once `.zshrc` sets `XDG_CONFIG_HOME`; `brew bundle dump --global --force --no-uv` rewrites it from what is installed, and it applies on macOS only.

The repo targets macOS and Linux; a Windows machine gets the editor settings by hand.
Settings Sync is off, so the repo owns the settings and the `vscode` lines in the Brewfile own the extensions.
No VS Code state is tracked: `globalStorage`, `workspaceStorage` and `History` stay local.

The hooks come from the `none` answer of [templates](https://github.com/ozanozbeker/templates), without its workflows: nothing runs on GitHub.
