#!/bin/bash

echo -n "Install all base packages (Y/n) => "; read base
if [[ $base != "n" ]] && [[ $base != "N" ]] ; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew update

    brew install zsh
    brew install zsh-autosuggestions
    brew install reattach-to-user-namespace
    brew install tmux
    brew install the_silver_searcher
    brew install ctags
    brew install wget curl
    brew tap caskroom/cask
    brew cask install iterm2
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

echo -n "Install NodeJS? (y/N) => "; read nodejs
if [[ $nodejs == "y" ]] || [[ $nodejs == "Y" ]] ; then
    sh -c "$(curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh)"
    . $HOME/.nvm/nvm.sh
    nvm install stable
    nvm alias default node
fi

echo -n "Install neovim? (y/N) => "; read nvim
if [[ $nvim == "y" ]] || [[ $nvim == "Y" ]] ; then
    brew install neovim/neovim/neovim
    brew install python3
    pip2 install neovim
    pip3 install neovim
fi

echo -n "Install Go? (y/N) => "; read go
if [[ $go == "y" ]] || [[ $go == "Y" ]] ; then
    goversion="1.8.1"
    goos="darwin"
    goarch="amd64"
    goname="go$goversion.$goos-$goarch.tar.gz"
    godl="https://storage.googleapis.com/golang/$goname"

    wget $godl
    sudo tar -C /usr/local -xvzf $goname
    rm -f $goname
fi

echo -n "Copy dotfiles to local? (y/N) => "; read co
if [[ $co == "y" ]] || [[ $co == "Y" ]] ; then
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
