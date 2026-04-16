# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh"

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

eval "$(/opt/homebrew/bin/brew shellenv)"

export MISE_SHELL=zsh
if [ -z "${__MISE_ORIG_PATH:-}" ]; then
  export __MISE_ORIG_PATH="$PATH"
fi
export __MISE_ZSH_PRECMD_RUN=0

mise() {
  local command
  command="${1:-}"
  if [ "$#" = 0 ]; then
    command /opt/homebrew/bin/mise
    return
  fi
  shift

  case "$command" in
  deactivate|shell|sh)
    # if argv doesn't contains -h,--help
    if [[ ! " $@ " =~ " --help " ]] && [[ ! " $@ " =~ " -h " ]]; then
      eval "$(command /opt/homebrew/bin/mise "$command" "$@")"
      return $?
    fi
    ;;
  esac
  command /opt/homebrew/bin/mise "$command" "$@"
}

_mise_hook() {
  eval "$(/opt/homebrew/bin/mise hook-env -s zsh)";
}
_mise_hook_precmd() {
  eval "$(/opt/homebrew/bin/mise hook-env -s zsh --reason precmd)";
}
_mise_hook_chpwd() {
  eval "$(/opt/homebrew/bin/mise hook-env -s zsh --reason chpwd)";
}
typeset -ag precmd_functions;
if [[ -z "${precmd_functions[(r)_mise_hook_precmd]+1}" ]]; then
  precmd_functions=( _mise_hook_precmd ${precmd_functions[@]} )
fi
typeset -ag chpwd_functions;
if [[ -z "${chpwd_functions[(r)_mise_hook_chpwd]+1}" ]]; then
  chpwd_functions=( _mise_hook_chpwd ${chpwd_functions[@]} )
fi

_mise_hook
if [ -z "${_mise_cmd_not_found:-}" ]; then
    _mise_cmd_not_found=1
    [ -n "$(declare -f command_not_found_handler)" ] && eval "${$(declare -f command_not_found_handler)/command_not_found_handler/_command_not_found_handler}"

    function command_not_found_handler() {
        if [[ "$1" != "mise" && "$1" != "mise-"* ]] && /opt/homebrew/bin/mise hook-not-found -s zsh -- "$1"; then
          _mise_hook
          "$@"
        elif [ -n "$(declare -f _command_not_found_handler)" ]; then
            _command_not_found_handler "$@"
        else
            echo "zsh: command not found: $1" >&2
            return 127
        fi
    }
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval $(ssh-agent)
export PATH="/opt/homebrew/opt/mysql@8.4/bin:$PATH"
export PATH="/opt/homebrew/opt/tomcat@9/bin:$PATH"

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/ehydrick/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
export PATH="/usr/local/opt/libpq/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq@16/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql@8.4/bin:$PATH"
export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
