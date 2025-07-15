# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="robbyrussell"

# Plugins
plugins=(git)
source $ZSH/oh-my-zsh.sh

###########
# Aliases #
###########

alias ls="lsd"
alias clip="xclip -selection clipboard"

#############
# ssh-agent #
#############

# Automatic inicialization of ssh-agent when login
if [ -z "$SSH_AGENT_PID" ]; then
    eval "$(ssh-agent -s)"
fi

# Auto load of private keys from ~/.ssh, it searchs for folders with
# the name id_*
# Comprobar si hay archivos que coincidan con el patrón
for key in ~/.ssh/id_*; do
    if [[ -f $key && $key != *.pub ]]; then
        ssh-add "$key"
    fi
done
echo "ssh-agent configurado"
