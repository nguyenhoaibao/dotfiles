# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

ZSH_THEME="robbyrussell"
CASE_SENSITIVE="true"

plugins=(git kubectl)
source $ZSH/oh-my-zsh.sh

# User configuration
alias vim="nvim"

export GOPATH="$HOME/Projects/go"
export GOROOT="/usr/local/go"

export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH=$PATH:"$GOROOT/bin":"$GOPATH/bin"
export PATH=$PATH:"$HOME/.cargo/bin"

if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
else
   export EDITOR='nvim'
fi

# Node verion manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh && bindkey '^ ' autosuggest-accept

eval "$(direnv hook zsh)"
