#!/bin/bash

sudo apt-get update
sudo apt-get install -y zsh ca-certificates curl gnupg silversearcher-ag ripgrep \
    git wget direnv tmux fonts-firacode fzf \
    xclip universal-ctags jq lsb-release apt-transport-https \
    make binutils bison gcc build-essential

# install neovim
sudo apt-get install -y python-dev python3-dev python3-pip python3-neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
sudo install -o root -g root -m 0755 nvim.appimage /usr/local/bin/nvim.appimage
pip3 install --user --upgrade pynvim msgpack

# install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.39.1/install.sh | bash
. $HOME/.nvm/nvm.sh
nvm install stable
nvm alias default node
npm install --global prettier neovim yarn

# install gvm
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
. $HOME/.gvm/scripts/gvm
gvm install go1.17 -B
gvm use go1.17 --default

# rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# install Docker
curl -fsSL https://get.docker.com | sh
sudo groupadd docker
sudo usermod -aG docker $USER

echo -n "Install kubectl and helm? (y/N) => "; read cp
if [[ $cp == "y" ]]; then
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x kubectl
    sudo mv kubectl /usr/local/bin/kubectl

    curl -LO https://get.helm.sh/helm-v3.8.0-linux-amd64.tar.gz
    tar xzf helm-v3.8.0-linux-amd64.tar.gz
    sudo mv linux-amd64/helm /usr/local/bin/helm
    rm -f helm-v3.8.0-linux-amd64.tar.gz
    rm -rf linux-amd64

    curl -LO https://github.com/derailed/k9s/releases/download/v0.25.18/k9s_Linux_x86_64.tar.gz
    tar xzf k9s_Linux_x86_64.tar.gz
    sudo mv k9s /usr/local/bin/k9s
    rm -f k9s_Linux_x86_64.tar.gz
    rm -f README.md
    rm -f LICENSE
fi

echo -n "Install gcloud? (y/N) => "; read cp
if [[ $cp == "y" ]]; then
    curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-371.0.0-linux-x86_64.tar.gz
    mkdir -p ~/.zsh
    tar xzf google-cloud-sdk-371.0.0-linux-x86_64.tar.gz -C ~/.zsh
    ~/.zsh/google-cloud-sdk/install.sh --quiet \
        --usage-reporting false \
        --path-update false \
        --command-completion false
fi

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

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

    echo "Copying dotfiles..."
    mkdir -p ~/.config/alacritty
    cp alacritty.yml ~/.config/alacritty/alacritty.yml
    cp -R nvim/init.vim ~/.config/nvim/init.vim

    mkdir -p ~/.zsh/functions
    cp zshrc ~/.zshrc
    cp zsh/functions/fbr ~/.zsh/functions/fbr
    cp tmux.linux.conf ~/.tmux.conf
fi

mkdir -p ~/.tmux

# install tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# kube-tmux
git clone https://github.com/jonmosco/kube-tmux.git ~/.tmux/kube-tmux
