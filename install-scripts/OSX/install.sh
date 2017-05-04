#!/bin/bash

echo -n "Install all base packages (Y/n) => "; read base
if [[ $base != "n" ]] && [[ $base != "N" ]] ; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew update

    brew install zsh
    brew install zsh-syntax-highlighting
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    brew install reattach-to-user-namespace
    brew install tmux
    brew install the_silver_searcher
    brew cask install iterm2
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
    brew install go
fi

echo -n "Install PHP? (y/N) => "; read php
if [[ $php == "y" ]] || [[ $php == "Y" ]] ; then
    xcode=$(xcode-select -p)
    if [[ -z "$xcode" ]] ; then
        echo "Please install Xcode Command Line tools by xcode-select --install. Then run this script again."
        exit 1
    fi
    brew install automake autoconf curl pcre bison re2c mhash libtool icu4c gettext jpeg openssl libxml2 mcrypt gmp libevent
    brew link icu4c
    brew link --force openssl
    brew link --force libxml2

    curl -L -O https://github.com/phpbrew/phpbrew/raw/master/phpbrew
    chmod +x phpbrew

    sudo mv phpbrew /usr/local/bin/phpbrew
    phpbrew init
    . ~/.phpbrew/bashrc
    phpbrew install 7.0
    phpbrew ext install mongo
    phpbrew ext enable mongo

    installed=$(phpbrew list | grep php | xargs)
    phpbrew switch $installed

    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
    php composer-setup.php
    php -r "unlink('composer-setup.php');"
    sudo mv composer.phar /usr/local/bin/composer
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
    cp .zshrc ~/.zshrc
    cp .tmux.conf ~/.tmux.conf
    mkdir -p ~/.config
    cp -R nvim ~/.config
fi
