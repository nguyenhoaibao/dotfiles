#!/bin/bash

sudo apt-get update
sudo apt-get install -y zsh
sudo apt-get install -y ca-certificates curl gnupg silversearcher-ag ripgrep \
    git wget direnv tmux fonts-firacode fzf \
    xclip universal-ctags jq lsb-release apt-transport-https \
    make binutils bison gcc build-essential

# install neovim
sudo apt-get install -y neovim python-dev python3-dev python3-pip python3-neovim

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
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
    bash get_helm.sh
    rm -f ./get_helm.sh
fi

echo -n "Install gcloud? (y/N) => "; read cp
if [[ $cp == "y" ]]; then
    # See https://cloud.google.com/sdk/docs/downloads-apt-get
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
    sudo apt-get update && sudo apt-get install google-cloud-sdk
fi

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

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
    cp zshrc ~/.zshrc
    cp tmux.linux.conf ~/.tmux.conf
    cp alacritty.yml ~/.config/alacritty/alacritty.yml
    cp -R nvim/init.vim ~/.config/nvim/init.vim
fi

# install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# install tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# kube-tmux
git clone https://github.com/jonmosco/kube-tmux.git ~/.tmux/kube-tmux
