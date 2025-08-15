if status is-interactive

  # Set fish shell options
  export EDITOR='nvim'

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
  fzf --fish | source
  export FZF_ALT_C_OPTS="
    --walker-skip .git,node_modules,target,Library,Applications,Music
    --preview 'tree -C {}'"

  #starship prompt
  starship init fish | source

  #fish prompt cursor style
  set fish_cursor_default line
  set fish_cursor_insert line
  set fish_cursor_replace_one underscore
  set fish_cursor_visual block

  # disable fish_greeting
  function fish_greeting
  end

end
