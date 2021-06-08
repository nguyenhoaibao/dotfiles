#!/bin/bash

sudo apt-get update
sudo apt-get install -y zsh
sudo apt-get install -y silversearcher-ag ripgrep
sudo apt-get install -y git wget direnv tmux alacritty fonts-firacode
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
bash -c "$(curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh)"
. $HOME/.nvm/nvm.sh
nvm install stable
nvm alias default node
npm install --global prettier neovim

# install Go
goversion="1.16"
goos="linux"
goarch="amd64"
goname="go$goversion.$goos-$goarch.tar.gz"
godl="https://storage.googleapis.com/golang/$goname"

wget $godl
sudo tar -C /usr/local -xvzf $goname
rm -f $goname

# install Docker
# See: https://docs.docker.com/install/linux/docker-ce/ubuntu/
sudo apt-get remove docker docker-engine docker.io containerd runc
DOCKER_DOWNLOAD_URL=https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64

urls=(
    "$DOCKER_DOWNLOAD_URL/docker-ce_19.03.0~3-0~ubuntu-bionic_amd64.deb"
    "$DOCKER_DOWNLOAD_URL/docker-ce-cli_19.03.0~3-0~ubuntu-bionic_amd64.deb"
    "$DOCKER_DOWNLOAD_URL/containerd.io_1.2.6-3_amd64.deb"
)

for url in "${urls[@]}"
do
    TMP_DEB="$(mktemp)" && wget -O "$TMP_DEB" "$url" && sudo dpkg -i "$TMP_DEB" && rm -f "$TMP_DEB"
done
sudo groupadd docker
sudo usermod -aG docker $USER
# install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

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
    cp tmux.linux.conf ~/.tmux.conf
    cp alacritty.yml ~/.config/alacritty/alacritty.yml
    mkdir -p ~/.config
    cp -R nvim ~/.config
fi

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# install tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
