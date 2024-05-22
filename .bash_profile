alias docker='podman'
alias ls='ls --color=auto'
alias vi='nvim'

JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/
PATH=$PATH:$HOME/bin:$JAVA_HOME/bin
export JAVA_HOME

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf

git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier
export PATH="$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"
