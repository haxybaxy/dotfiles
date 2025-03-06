export ZSH="$HOME/.oh-my-zsh"
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

#vim alias
alias v="nvim"
alias nv="neovide &"

#better cat command
alias cat="bat"

#env variables
[ -f ~/.env.local.zsh ] && source ~/.env.local.zsh

#fzf ignore paths
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target,Library,Applications,Music
  --preview 'tree -C {}'"

#obsidian location

alias obs="cd /Users/zaidsaheb/Library/Mobile Documents/iCloud~md~obsidian/Documents/vault16"
