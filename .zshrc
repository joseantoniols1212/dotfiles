################################################################
#   MY ZSH					       	       #
################################################################
#                					       #
#   This is my .zshrc file, my main configuration for this     #
#   file is in .main.zsh as after installation many programs   #
#   need to modify .zshrc in order to add their binaries to    #
#   the path.                                                  #
#                					       #
################################################################

# Load my personal config
source $HOME/.config/zsh/main.zsh

################################################################
# External config
################################################################

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=/usr/local/swift/usr/bin:$PATH

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
export PATH=$PATH:$HOME/.local/opt/go/bin

# bun completions
[ -s "/home/joseantoniols1212/.bun/_bun" ] && source "/home/joseantoniols1212/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/joseantoniols1212/google-cloud-sdk/path.zsh.inc' ]; then . '/home/joseantoniols1212/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/joseantoniols1212/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/joseantoniols1212/google-cloud-sdk/completion.zsh.inc'; fi

# Turso
export PATH="$PATH:/home/joseantoniols1212/.turso"
