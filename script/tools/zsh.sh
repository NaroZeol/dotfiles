#! /bin/bash
set -e

# zsh
if command -v zsh >/dev/null 2>&1; then
    echo -e "\e[32mzsh is already installed.\e[0m"
else
    echo -e "\e[31mYou need to install zsh first.\e[0m"
    exit 1
fi

# oh-my-zsh
# https://ohmyz.sh/
if [ -d ~/.oh-my-zsh ]; then
    echo -e "\e[32moh-my-zsh is already installed.\e[0m"
else
    echo -e "\e[32mInstalling oh-my-zsh...\e[0m"
    curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh > /tmp/install_oh_my_zsh.sh
    sh /tmp/install_oh_my_zsh.sh  --noreplace-rc --unattended
    rm /tmp/install_oh_my_zsh.sh
    echo -e "\e[32moh-my-zsh installed.\e[0m"
    sleep 1
fi


# zsh-autosuggestions
# https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh
if [ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]; then
    echo -e "\e[32mzsh-autosuggestions is already installed.\e[0m"
else
    echo -e "\e[32mInstalling zsh-autosuggestions...\e[0m"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    echo -e "\e[32mzsh-autosuggestions installed.\e[0m"
    sleep 1
fi

# zsh-syntax-highlighting
# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#oh-my-zsh
if [ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]; then
    echo -e "\e[32mzsh-syntax-highlighting is already installed.\e[0m"
else
    echo -e "\e[32mInstalling zsh-syntax-highlighting...\e[0m"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    echo -e "\e[32mzsh-syntax-highlighting installed.\e[0m"
    sleep 1
fi

# starship
# https://starship.rs/guide/#%F0%9F%9A%80-installation
if command -v starship >/dev/null 2>&1; then
    echo -e "\e[32mstarship is already installed.\e[0m"
else
    echo -e "\e[32mInstalling starship...\e[0m"
    yes | sh -c "$(curl -sS https://starship.rs/install.sh)"
    echo -e "\e[32mstarship installed.\e[0m"
    sleep 1
fi
