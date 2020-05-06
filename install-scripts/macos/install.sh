#!/bin/bash

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update

brew install zsh
brew install the_silver_searcher ripgrep
brew install git wget direnv tmux reattach-to-user-namespace gawk
brew tap caskroom/cask
brew tap universal-ctags/universal-ctags
brew install --HEAD universal-ctags
brew cask install alacritty
brew tap homebrew/cask-fonts
brew cask install font-fira-code

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
npm install --global prettier neovim

# install Go
goversion="1.13"
goos="darwin"
goarch="amd64"
goname="go$goversion.$goos-$goarch.tar.gz"
godl="https://storage.googleapis.com/golang/$goname"

wget $godl
sudo tar -C /usr/local -xvzf $goname
rm -f $goname
# install gotags
brew install gotags

echo -n "Install kubectl and helm? (y/N) => "; read cp
if [[ $cp == "y" ]]; then
    curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl

    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
    BINARY_NAME=helm3 bash get_helm.sh
    rm -f ./get_helm.sh
fi

echo -n "Install gcloud? (y/N) => "; read cp
if [[ $cp == "y" ]]; then
    # See https://cloud.google.com/sdk/docs/downloads-apt-get
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
    sudo apt-get install apt-transport-https ca-certificates gnupg
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
    sudo apt-get update && sudo apt-get install google-cloud-sdk
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

    echo "Copying dotfiles"
    cp zshrc ~/.zshrc
    cp tmux.macos.conf ~/.tmux.conf
    cp alacritty.yml ~/.config/alacritty/alacritty.yml
    mkdir -p ~/.config
    cp -R nvim ~/.config
fi

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# install tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
