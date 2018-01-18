#!/bin/bash

echo -n "Install all base packages (y/N) => "; read base
if [[ $base != "n" ]] && [[ $base != "N" ]] ; then
    sudo apt-get install -y zsh
    sudo apt-get install -y zsh-syntax-highlighting
    sudo apt-get install -y tmux
    sudo apt-get install -y silversearcher-ag
    sudo apt-get install -y xclip
    sudo apt-get install -y exuberant-ctags
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
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
    sudo apt-get install -y software-properties-common
    sudo add-apt-repository -y ppa:neovim-ppa/stable
    sudo apt-get update -y
    sudo apt-get install -y neovim
    sudo apt-get install -y python-dev python-pip python3-dev python3-pip
    pip2 install neovim
    pip3 install neovim
fi

echo -n "Install Go? (y/N) => "; read go
if [[ $go == "y" ]] || [[ $go == "Y" ]] ; then
    goversion="1.8.1"
    goos="linux"
    goarch="amd64"
    goname="go$goversion.$goos-$goarch.tar.gz"
    godl="https://storage.googleapis.com/golang/$goname"

    wget $godl
    sudo tar -C /usr/local -xvzf $goname
    rm -f $goname
fi

echo -n "Install PHP? (y/N) => "; read php
if [[ $php == "y" ]] || [[ $php == "Y" ]] ; then
    sudo apt-get build-dep php7.0
    sudo apt-get install -y php7.0 php7.0-dev php-pear autoconf automake curl libcurl4-openssl-dev build-essential libxslt1-dev re2c libxml2 libxml2-dev php7.0-cli bison libbz2-dev libreadline-dev
    sudo apt-get install -y libfreetype6 libfreetype6-dev libpng12-0 libpng12-dev libjpeg-dev libjpeg8-dev libjpeg8  libgd-dev libgd3 libxpm4 libltdl7 libltdl-dev
    sudo apt-get install -y libssl-dev openssl
    sudo apt-get install -y gettext libgettextpo-dev libgettextpo0
    sudo apt-get install -y libicu-dev
    sudo apt-get install -y libmhash-dev libmhash2
    sudo apt-get install -y libmcrypt-dev libmcrypt4

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
    # if [[ -f ~/.ctags ]]; then
    #     mv ~/.ctags ~/.ctags.$(date +%s)
    # fi

    echo "Copying dotfiles"
    cp zshrc ~/.zshrc
    cp tmux.linux.conf ~/.tmux.conf
    # cp ctags ~/.ctags
    mkdir -p ~/.config
    cp -R nvim ~/.config
fi
