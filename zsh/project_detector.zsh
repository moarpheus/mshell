# vim: filetype=zsh
# Smart project detection via chpwd hook

typeset -a _mshell_visited_dirs=()
typeset -a _mshell_env_warned=()
typeset _MSHELL_NODE_BIN=""

_mshell_add_node_bin() {
  local node_bin="$PWD/node_modules/.bin"
  if [[ -d "$node_bin" ]]; then
    # Remove previous node_modules/.bin if any
    _mshell_remove_node_bin
    export PATH="$node_bin:$PATH"
    _MSHELL_NODE_BIN="$node_bin"
  fi
}

_mshell_remove_node_bin() {
  if [[ -n "$_MSHELL_NODE_BIN" ]]; then
    export PATH="${PATH//$_MSHELL_NODE_BIN:/}"
    _MSHELL_NODE_BIN=""
  fi
}

_mshell_show_make_targets() {
  local targets
  targets=$(grep -E '^[a-zA-Z_-]+:' Makefile 2>/dev/null | head -20 | cut -d: -f1 | tr '\n' ', ' | sed 's/,$//')
  if [[ -n "$targets" ]]; then
    echo "📋 Make targets: $targets"
  fi
}

_mshell_project_detect() {
  # Node.js project detection
  if [[ -f "package.json" ]]; then
    _mshell_add_node_bin
  else
    _mshell_remove_node_bin
  fi

  # Makefile targets display (once per directory per session)
  if [[ -f "Makefile" ]] && ! (( ${_mshell_visited_dirs[(I)$PWD]} )); then
    _mshell_visited_dirs+=("$PWD")
    _mshell_show_make_targets
  fi

  # .env handling
  if [[ -f ".env" ]]; then
    if ! type direnv &>/dev/null; then
      if ! (( ${_mshell_env_warned[(I)$PWD]} )); then
        _mshell_env_warned+=("$PWD")
        echo "⚠️  .env found but direnv is not installed. Run: brew install direnv"
      fi
    fi
  fi
}

autoload -Uz add-zsh-hook
add-zsh-hook chpwd _mshell_project_detect
