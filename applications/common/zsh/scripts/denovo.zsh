# Denovo Zsh Plugin
plugins=(
  "denovo-abbrev"
  "denovo-benchmark"
  "denovo-complete"
  "denovo-example"
  "denovo-fzf"
  "denovo-rootmake"
)

# Load Denovo plugins
for p in ${plugins[@]}; do
  if [[ -f "$HOME/ghq/github.com/Warashi/${p}/${p}.plugin.zsh" ]]; then
    source "$HOME/ghq/github.com/Warashi/${p}/${p}.plugin.zsh"
  fi
done

# Load Denovo main plugin
if [[ -f "$HOME/ghq/github.com/Warashi/denovo.zsh/denovo.plugin.zsh" ]]; then
  source "$HOME/ghq/github.com/Warashi/denovo.zsh/denovo.plugin.zsh"
fi

# Key Bindings
if type denovo-fzf-ghq-cd &>/dev/null; then
  bindkey "^x" denovo-fzf-ghq-cd
fi

if type denovo-abbrev-expand &>/dev/null; then
  bindkey ' '  denovo-abbrev-expand
fi

if type denovo-abbrev-expand-and-accept-line &>/dev/null; then
  bindkey '^m' denovo-abbrev-expand-and-accept-line
fi

if type denovo-complete &>/dev/null; then
  bindkey '^i' denovo-complete
fi
