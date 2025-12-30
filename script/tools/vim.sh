#! /bin/bash

set -e

# check vim version (need at least 9.0, for coc.nvim)
VIM_VERSION="0.0"
VIM_MAJOR_VERSION="0"
if command -v vim >/dev/null 2>&1; then
    VIM_VERSION=$(vim --version | head -n 1 | awk '{print $5}')
    VIM_MAJOR_VERSION=$(echo $VIM_VERSION | cut -d. -f1)
fi
if [ "$VIM_MAJOR_VERSION" -lt 9 ]; then
    echo -e "\e[32mInstalling vim version 9.0 or higher...(compile from source)\e[0m"
    PWD=$(pwd)
    cd /tmp && git clone https://github.com/vim/vim.git --depth 1 --single-branch && cd vim/src
    make && sudo make install
    rm -rf vim
    cd "$PWD"
    echo -e "\e[32mvim version 9.0 or higher installed. Please remove old versions manually.\e[0m"
    sleep 1
else
    echo -e "\e[32mvim version $VIM_VERSION is installed.\e[0m"
fi

# nodejs (need at least version 16.18 for coc.nvim)
# https://nodejs.org/en/download/package-manager/
NODE_VERSION="0.0.0"
NODE_MAJOR_VERSION="0"
if command -v node >/dev/null 2>&1; then
    NODE_VERSION=$(node --version | sed 's/^v//')
    NODE_MAJOR_VERSION=$(echo "$NODE_VERSION" | cut -d. -f1)
fi
if [ "$NODE_MAJOR_VERSION" -lt 16 ]; then
    echo -e "\e[32mInstalling Node.js version 16.18 or higher...(using nvm)\e[0m"
    # Download and install nvm:
    PROFILE=/dev/null sh -c 'curl -s -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash'
    # in lieu of restarting the shell
    \. "$HOME/.nvm/nvm.sh"
    # Download and install Node.js:
    nvm install 24

    cat <<EOF >> ~/.zshrc.local
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
EOF

    echo -e "\e[32mNode.js version $(node --version) installed.\e[0m"
    sleep 1
else
    echo -e "\e[32mNode.js version $NODE_VERSION is installed.\e[0m"
fi

# vim-plug
# https://github.com/junegunn/vim-plug
if [ -f ~/.vim/autoload/plug.vim ]; then
    echo -e "\e[32mvim-plug is already installed.\e[0m"
else
    echo -e "\e[32mInstalling vim-plug...\e[0m"
    curl -sfLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo -e "\e[32mvim-plug installed.\e[0m"
    sleep 1
fi

# install plugins
vim +PlugInstall +qall
