# Omarchy environment (OMARCHY_PATH + PATH), needed even for non-interactive shells
[[ -r /usr/share/omarchy/default/bash/env-bootstrap ]] && source /usr/share/omarchy/default/bash/env-bootstrap

# If not running interactively, don't do anything else (leave this above the rc source)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source "$OMARCHY_PATH/default/bash/rc"

# Use the 1Password SSH agent for SSH key access
if [[ -S ~/.1password/agent.sock ]]; then
    export SSH_AUTH_SOCK=~/.1password/agent.sock
fi

# Add your own exports, aliases, and functions here.
export EDITOR=nvim
export VISUAL=nvim

# opencode
export PATH=~/.opencode/bin:$PATH

# Tool-specific setup
eval "$(mise activate bash)"
eval "$(fzf --bash)"
source <(jj util completion bash)

# Turso
. "$HOME/.turso/env"
