#!/bin/bash
# Installing config script (ubuntu)

########################
# Helper functions
########################

install_package() {
  local PAQUETE=$1

  # Comprobar si el paquete ya está instalado
  if dpkg -l | grep -qw "$PAQUETE"; then
    echo "'$PAQUETE' alreday installed."
  else
    echo "Installing '$PAQUETE'..."
    sudo apt install -y "$PAQUETE" -qq > /dev/null 2>&1

    if dpkg -l | grep -qw "$PAQUETE"; then
      echo "'$PAQUETE' installed successfully."
    else
      echo "Error installing '$PAQUETE'."
      return 1
    fi
  fi
}

create_symlink() {
  local ORIGIN=$1
  local DESTINY=$2
  rm -r $DESTINY
  ln -s "$ORIGIN" "$DESTINY"
  echo "Symlink created: $ORIGIN -> $DESTINY"
}


####################################
# Install packages
####################################
echo "Intalling packages"
sudo apt-get update > /dev/null 2>&1
sudo apt-get upgrade > /dev/null 2>&1

install_package git                         # git
install_package curl
install_package build-essential             # gcc, g++...
install_package python3                     # python
install_package alacritty                   # terminal
install_package zsh                         # shell
install_package lsd                         # sustituto ls
install_package xclip                       # clipboard
install_package sway                        # window tiling manager
install_package waybar                      # status bar
install_package wofi                        # app launcher

####################################
# Nerd Font Jetbrains
####################################

FONT_NAME="JetBrainsMono"
FONT_VERSION="v3.0.2"
DOWNLOAD_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/${FONT_VERSION}/${FONT_NAME}.zip"
FONT_DIR="$HOME/.local/share/fonts"

if fc-list | grep -iq "$FONT_NAME"; then
  echo "'$FONT_NAME' already installed."
else
	mkdir -p "$FONT_DIR"

	echo "Downloading ${FONT_NAME} Nerd Font..."
	curl -s -L -o "${FONT_NAME}.zip" "$DOWNLOAD_URL"

	if [ $? -ne 0 ]; then
	  echo "Error downloading font."
	else
	  echo "Extract font..."
	  unzip -q "${FONT_NAME}.zip" -d "$FONT_DIR"  
	  rm "${FONT_NAME}.zip"  
	  echo "Update cache font..."
	  fc-cache -fv &>/dev/null  
	  if fc-list | grep -i "JetBrainsMono" > /dev/null 2>&1; then
	    echo "JetBrains Mono Nerd Font correctly installed."
	  else
	    echo "Error installing JetBrains Mono Nerd Font."
	    exit 1
	  fi
	fi
fi

#########################
# Install oh-my-zsh
#########################

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  export RUNZSH=no
  export CHSH=no
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  sudo chsh -s $(which zsh) $USER
else
  echo "Oh-my-zsh already installed"
fi 

####################
# Set configs
####################
create_symlink "$HOME/dotfiles/zsh" "$HOME/.config/zsh"
create_symlink "$HOME/dotfiles/.zshrc" "$HOME/.zshrc"
create_symlink "$HOME/dotfiles/alacritty" "$HOME/.config/alacritty"
create_symlink "$HOME/dotfiles/.gitconfig" "$HOME/.gitconfig"
