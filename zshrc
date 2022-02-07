export ZSH="$HOME/.oh-my-zsh"
export FZF_BASE="$HOME/.fzf"

ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions fzf kubectl helm terraform minikube)

source $ZSH/oh-my-zsh.sh
source <(helm completion zsh)

alias vim="nvim.appimage"
alias nvim="nvim.appimage"
alias t="terraform"
if [ -f ~/.zsh/alias ]; then
  source ~/.zsh/alias
fi

export EDITOR="/usr/local/bin/nvim.appimage"
export GOPATH="$HOME/go"
export GOROOT="/usr/local/go"
export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/snap/bin"
export PATH=$PATH:"$GOROOT/bin":"$GOPATH/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

bindkey '^ ' autosuggest-accept

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--bind=ctrl-f:preview-down,ctrl-b:preview-up'

eval "$(direnv hook zsh)"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

fpath=(
  ~/.zsh/functions
  $fpath
)
autoload -Uz $fpath[1]/*(.:t)
