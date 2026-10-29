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

alias clod="claude"

# Better ls
alias ls="lsd"

alias cm="cmatrix"

# Activate and deactivate venv
alias av="source .venv/bin/activate"
alias dav="deactivate"

# Better cat
alias cat="bat"

# Fzf (completion + key bindings: Ctrl+R history, Ctrl+T files, Alt+C cd)
source <(fzf --zsh)

# Vim alias
alias v="nvim"
alias vim="nvim"

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
bindkey '^G' edit-command-line

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

# Fzf Ctrl+R history search: preview full command, toggle with Ctrl+/
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window down:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'"

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

# ngrok completions
if command -v ngrok &>/dev/null; then
  eval "$(ngrok completion)"
fi

# Syntax highlight
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Auto suggestions
if [[ -r "$HOME/.local/share/deja/init.zsh" ]]; then source "$HOME/.local/share/deja/init.zsh"; else eval "$(deja init zsh)"; fi

# Path config
export PATH="$HOME/.local/bin:$PATH"

# Better cd
if [[ "$CLAUDECODE" != "1" ]]; then
    eval "$(zoxide init --cmd cd zsh)"
fi


# Better history (native zsh history powers fzf Ctrl+R)
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt extended_history      # save timestamp and duration for each command
setopt hist_ignore_all_dups  # drop older duplicates so fzf shows each command once
setopt hist_ignore_space     # don't record commands prefixed with a space
setopt hist_reduce_blanks    # trim redundant whitespace before saving
setopt hist_verify           # show a recalled command before running it
setopt append_history
setopt share_history
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt no_beep
setopt inc_append_history

# Starship prompt
eval "$(starship init zsh)"

# Notify command
notify() {
  "$@"
  afplay /System/Library/Sounds/Glass.aiff
}

autoload -U add-zsh-hook

auto_activate_venv() {
    local venv_path="$PWD/.venv"

    if [[ -f "$venv_path/bin/activate" ]]; then
        if [[ "$VIRTUAL_ENV" != "$venv_path" ]]; then
            source "$venv_path/bin/activate"
        fi
    elif [[ -n "$VIRTUAL_ENV" ]]; then
        deactivate 2>/dev/null
    fi
}

add-zsh-hook chpwd auto_activate_venv
auto_activate_venv

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi

export AWS_PROFILE=zaid
