#!/bin/bash

sudo apt-get install -y zsh
sudo apt-get install -y tmux git
sudo apt-get install -y silversearcher-ag direnv
sudo apt-get install -y xclip
sudo apt-get install -y universal-ctags

# install neovim
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo apt-get update -y
sudo apt-get install -y neovim
sudo apt-get install -y python-dev python-pip python3-dev python3-pip
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
goos="linux"
goarch="amd64"
goname="go$goversion.$goos-$goarch.tar.gz"
godl="https://storage.googleapis.com/golang/$goname"

wget $godl
sudo tar -C /usr/local -xvzf $goname
rm -f $goname
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
    cp tmux.linux.conf ~/.tmux.conf
    mkdir -p ~/.config
    cp -R nvim ~/.config
fi

# install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
