#!/bin/bash

echo -n "Install all base packages (y/N) => "; read answer
if [[ $answer != "n" ]] && [[ $answer != "N" ]] ; then
    sudo apt-get -y install zsh
    sudo apt-get install zsh-syntax-highlighting
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    sudo apt-get install tmux
    sudo apt-get install silversearcher-ag
fi

echo -n "Install NodeJS? (y/N) => "; read nodejs
if [[ $nodejs == "y" ]] || [[ $nodejs == "Y" ]] ; then
    sh -c $(curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh)
    . $HOME/.nvm/nvm.sh
    nvm install stable
    nvm alias default node
fi

echo -n "Install neovim? (y/N) => "; read nvim
if [[ $nvim == "y" ]] || [[ $nvim == "Y" ]] ; then
    sudo apt-get install software-properties-common
    sudo add-apt-repository ppa:neovim-ppa/stable
    sudo apt-get update
    sudo apt-get install neovim
    sudo apt-get install python-dev python-pip python3-dev python3-pip
    pip2 install neovim
    pip3 install neovim
fi

echo -n "Install Go? (y/N) => "; read go
if [[ $go == "y" ]] || [[ $go == "Y" ]] ; then
    sudo apt-get install golang-1.8-go
fi

echo -n "Install PHP? (y/N) => "; read php
if [[ $php == "y" ]] || [[ $php == "Y" ]] ; then
    #sudo apt-get install libbz2-dev
    curl -L -O https://github.com/phpbrew/phpbrew/raw/master/phpbrew
    chmod +x phpbrew

    sudo mv phpbrew /usr/local/bin/phpbrew
    phpbrew install 7.0 +default+dbs
    phpbrew ext install mongo
    phpbrew ext enable mongo

    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
    php composer-setup.php
    php -r "unlink('composer-setup.php');"
    sudo mv composer.phar /usr/local/bin/composer
fi

echo -n "Copy dotfiles to local? (y/N) => "; read co
if [[ $co == "y" ]] || [[ $co == "Y" ]] ; then
    echo "Backing up old dotfiles"
    mv ~/.zshrc ~/.zshrc.$(date +%s)
    mv ~/.tmux.conf ~/.tmux.conf.$(date +%s)
    mv ~/.vim ~/.vim.$(date +%s)
    mv ~/.vimrc ~/.vimrc.$(date +%s)

    echo "Copying dotfiles"
    cp ../../.zshrc ~/.zshrc
    cp ../../.tmux.conf ~/.tmux.conf
    mkdir ~/.vim
    cp -R ../../vim/* ~/.vim/
    cp ../../.vimrc ~/.vimrc
fi
