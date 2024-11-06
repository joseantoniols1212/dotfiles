#!/bin/bash

# Creamos symlinks para las configuraciones
if [ ! -f "$HOME/.zshrc" ]; then
	ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc
	echo "zsh configured!"
fi
if [ ! -d "$HOME/.config/kitty" ]; then
	ln -s $HOME/dotfiles/kitty $HOME/.config/kitty
	echo "kitty configured!"
fi
