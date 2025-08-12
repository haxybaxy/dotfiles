if status is-interactive

# better cd
zoxide init fish | source
alias cd="z"

#better Ls
alias ls="lsd"

#vim alias
alias v="nvim"
alias vim="nvim"
alias nv="neovide &"

#lazygit alias
alias lg="lazygit"

#fzf ignore paths
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target,Library,Applications,Music
  --preview 'tree -C {}'"

end
starship init fish | source
