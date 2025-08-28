export ZSH="$HOME/.oh-my-zsh"

export EDITOR='nvim'

# Custom theme
ZSH_THEME="zaid"

plugins=(
        git
        zsh-autosuggestions
        zsh-syntax-highlighting
       )

source $ZSH/oh-my-zsh.sh

# Make valid commands appear in blue for zsh-syntax-highlighting
ZSH_HIGHLIGHT_STYLES[command]='fg=blue'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=blue'
ZSH_HIGHLIGHT_STYLES[alias]='fg=blue'

# For lazygit and other apps to find config
export XDG_CONFIG_HOME="$HOME/.config"

# Preferred terminal for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export TERM='xterm-256color'
fi

# Better cd 
if [ -z "$DISABLE_ZOXIDE" ]; then
  eval "$(zoxide init --cmd cd zsh)"
  alias cd="z"
fi

# Better ls
alias ls="lsd"

# Better cat
alias cat="bat"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# vim alias
alias v="nvim"
alias vim="nvim"
alias nv="neovide &"

# Lazygit alias
alias lg="lazygit"

# Env variables
[ -f ~/.env.local.zsh ] && source ~/.env.local.zsh

# Fzf ignore paths
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target,Library,Applications,Music
  --preview 'tree -C {}'"

# Carapace
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

# NVM setup
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completio

# Docker CLI completions
fpath=(/Users/zaidalsaheb/.docker/completions $fpath)
autoload -Uz compinit
compinit
