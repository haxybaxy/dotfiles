export EDITOR='nvim'

autoload -Uz compinit
compinit

# enable prompt command substitution so $(...) runs every time the prompt is drawn
setopt PROMPT_SUBST

autoload -U colors && colors
# helper: print branch if we're inside a git repo
git_branch() {
  git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return
  local branch dirty
  branch=$(git symbolic-ref --short HEAD 2>/dev/null) || branch=$(git rev-parse --short --verify HEAD 2>/dev/null)

  # Check if repo is dirty (uncommitted changes)
  if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
    dirty="*"
  fi

  [[ -n $branch ]] && echo "${branch}${dirty} "
}
# prompt: use %F/%f (built-in color escapes) so we don't rely on $fg being set
PROMPT='%~ %F{blue}$(git_branch)%fλ '


# For lazygit and other apps to find config
export XDG_CONFIG_HOME="$HOME/.config"

# Preferred terminal for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export TERM='xterm-256color'
fi

# Better cd 
if [ -z "$DISABLE_ZOXIDE" ]; then
  eval "$(zoxide init zsh)"
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

# bun completions
[ -s "/Users/zaidalsaheb/.bun/_bun" ] && source "/Users/zaidalsaheb/.bun/_bun"

# syntax highlight
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# auto suggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

