export EDITOR='nvim'
ZLE_RPROMPT_INDENT=0

autoload -Uz compinit
compinit

# enable prompt command substitution so $(...) runs every time the prompt is drawn
setopt PROMPT_SUBST

autoload -U colors && colors

# # custom prompt
# helper: print branch if we're inside a git repo
# git_branch() {
#   git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return
#   local branch dirty
#   branch=$(git symbolic-ref --short HEAD 2>/dev/null) || branch=$(git rev-parse --short --verify HEAD 2>/dev/null)
#
#   # Check if repo is dirty (uncommitted changes)
#   if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
#     dirty="*"
#   fi
#
#   [[ -n $branch ]] && echo "${branch}${dirty} "
# }
# # prompt: use %F/%f (built-in color escapes) so we don't rely on $fg being set
# PROMPT='λ %~ %F{blue}$(git_branch)%f'


# For lazygit and other apps to find config
export XDG_CONFIG_HOME="$HOME/.config"

# Preferred terminal for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export TERM='xterm-256color'
fi

alias clod="claude --permission-mode plan --dangerously-skip-permissions --effort max"

# Better ls
alias ls="lsd"

# Activate and deactivate venv
alias av="source .venv/bin/activate"
alias dav="deactivate"

# Better cat
alias cat="bat"

# Fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Vim alias
alias v="nvim"
alias vim="nvim"
alias nv="neovide &"

export EDITOR="nvim"
export VISUAL="nvim"


# Lazygit alias
alias lg="lazygit"

# Env variables
[ -f ~/.env.local.zsh ] && source ~/.env.local.zsh

bindkey -e
bindkey '^[[1;3C' forward-word
bindkey '^[[1;3D' backward-word

# Edit command in nvim
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^E' edit-command-line

# Take out and bring back programs
function fancy-ctrl-z() {
  if [[ -z $BUFFER ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}

zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

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

# docker CLI completions
fpath=(/Users/zaidalsaheb/.docker/completions $fpath)

# Bun completions
[ -s "/Users/zaidalsaheb/.bun/_bun" ] && source "/Users/zaidalsaheb/.bun/_bun"

# Syntax highlight
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Auto suggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Path config
export PATH="$HOME/.local/bin:$PATH"

# Better cd
if [[ "$CLAUDECODE" != "1" ]]; then
    eval "$(zoxide init --cmd cd zsh)"
fi


# Better history
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh --disable-up-arrow)"

# Starship prompt
eval "$(starship init zsh)"

# Notify command
notify() {
  "$@"
  afplay /System/Library/Sounds/Glass.aiff
}

# Yazi changes cwd
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi
