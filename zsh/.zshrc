# === Pure Prompt ===
fpath+=("$(brew --prefix)/share/zsh/site-functions")
autoload -U promptinit
promptinit
prompt pure

# === Quality of Life ===
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt inc_append_history
setopt share_history
setopt auto_cd
setopt correct
setopt prompt_subst

# === Aliases ===
alias cat="bat"
alias ll="eza -lao --header --icons"

# === Enable Homebrew plugins ===
if [ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
