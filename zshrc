export ZSH="$HOME/.oh-my-zsh"
export FZF_BASE="$HOME/.fzf"

ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions fzf kubectl helm)

source $ZSH/oh-my-zsh.sh

alias vim="nvim"
alias tx="tmuxinator"

export EDITOR="/usr/bin/nvim"
export GOPATH="$HOME/go"
export GOROOT="/usr/local/go"
export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH=$PATH:"$GOROOT/bin":"$GOPATH/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

bindkey '^ ' autosuggest-accept

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(direnv hook zsh)"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
