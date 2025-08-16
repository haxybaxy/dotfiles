if status is-interactive

  # Set fish shell options
  export EDITOR='nvim'

  # better cd
  zoxide init fish | source
  alias cd="z"

  #better ls
  alias ls="lsd"

  #better cat
  alias cat="bat"

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

  #for lazygit and others
  export XDG_CONFIG_HOME="$HOME/.config"

  function nvm
  bass source (brew --prefix nvm)/nvm.sh --no-use ';' nvm $argv
  end

  set -x NVM_DIR ~/.nvm
  nvm use default --silent

  # disable fish_greeting
  function fish_greeting
  end

end
