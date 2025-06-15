export ZSH="$HOME/.oh-my-zsh"

export EDITOR='nvim'

ZSH_THEME="lambda"
plugins=(
        git
        zsh-autosuggestions
        zsh-syntax-highlighting
       )

source $ZSH/oh-my-zsh.sh

# Preferred terminal for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export TERM='xterm-256color'
fi

# better cd
eval "$(zoxide init zsh)"
alias cd="z"

#better Ls
alias ls="lsd"

#fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#vim alias
alias v="nvim"
alias nv="neovide &"

#lazygit alias
alias lg="lazygit"

#env variables
[ -f ~/.env.local.zsh ] && source ~/.env.local.zsh

#fzf ignore paths
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target,Library,Applications,Music
  --preview 'tree -C {}'"

# carapace
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

#obsidian location
alias obsidian="cd /Users/zaidsaheb/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/vault16"

#nvm setup
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completio

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/zaidalsaheb/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

