#!/bin/bash

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update

brew install zsh
brew install tmux reattach-to-user-namespace gawk
brew install wget curl the_silver_searcher direnv
brew tap caskroom/cask
brew tap universal-ctags/universal-ctags
brew cask install iterm2
brew install --HEAD universal-ctags

# install neovim
brew install neovim
brew install python3
pip2 install neovim
pip3 install neovim

# install NodeJS
sh -c "$(curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh)"
. $HOME/.nvm/nvm.sh
nvm install stable
nvm alias default node
npm install --global prettier

# install Go
goversion="1.12.7"
goos="darwin"
goarch="amd64"
goname="go$goversion.$goos-$goarch.tar.gz"
godl="https://storage.googleapis.com/golang/$goname"

wget $godl
sudo tar -C /usr/local -xvzf $goname
rm -f $goname
# install gotags
brew install gotags
# install golangci-lint
go get -u github.com/golangci/golangci-lint/cmd/golangci-lint

echo -n "Copy dotfiles to local? (y/N) => "; read cp
if [[ $cp == "y" ]] || [[ $cp == "Y" ]] ; then
    echo "Backing up old dotfiles"
    if [[ -f ~/.zshrc ]]; then
        mv ~/.zshrc ~/.zshrc.$(date +%s)
    fi
    if [[ -f ~/.tmux.conf ]]; then
        mv ~/.tmux.conf ~/.tmux.conf.$(date +%s)
    fi
    if [[ -d ~/.vim ]]; then
        mv ~/.vim ~/.vim.$(date +%s)
    fi
    if [[ -f ~/.vimrc ]]; then
        mv ~/.vimrc ~/.vimrc.$(date +%s)
    fi

    echo "Copying dotfiles"
    cp zshrc ~/.zshrc
    cp tmux.macos.conf ~/.tmux.conf
    mkdir -p ~/.config
    cp -R nvim ~/.config
fi

# install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
