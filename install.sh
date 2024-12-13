#!/bin/bash
# Archivo de instalacion de mi configuracion (para ubuntu)

# Función para comprobar e instalar un paquete por apt
instalar_paquete() {
  local PAQUETE=$1

  # Comprobar si el paquete ya está instalado
  if dpkg -l | grep -qw "$PAQUETE"; then
    echo "El paquete '$PAQUETE' ya está instalado."
  else
    echo "El paquete '$PAQUETE' no está instalado. Procediendo con la instalación..."
    sudo apt install -y "$PAQUETE" -qq > /dev/null 2>&1

    # Verificar si la instalación fue exitosa
    if dpkg -l | grep -qw "$PAQUETE"; then
      echo "El paquete '$PAQUETE' se instaló correctamente."
    else
      echo "Hubo un problema al instalar el paquete '$PAQUETE'."
      return 1
    fi
  fi
}

# Función para crear symlinks con respaldo
crear_symlink_con_respaldo() {
  local origen=$1
  local destino=$2

  # Si el archivo o carpeta ya existe en el destino
  if [ -e "$destino" ]; then
    # Hacer un respaldo con el sufijo _old
    local respaldo="${destino}_old"
	if [ -e "$respaldo" ]; then
	  echo "Respaldo de $destino ya existente"
	  rm -r $destino
	else
	  mv "$destino" "$respaldo"
          echo "Respaldo creado: $respaldo"
	fi
  fi

  # Crear el symlink
  ln -s "$origen" "$destino"
  echo "Symlink creado: $destino -> $origen"
}

########################################
# Actualizamos repositorios y paquetes
########################################
echo "Actualizando repositorios y paquetes"
sudo apt update -qq > /dev/null 2>&1
sudo apt upgrade -y -qq > /dev/null 2>&1

####################################
# Instalamos paquetes generales
####################################
instalar_paquete git                         # git
instalar_paquete curl                        # herramienta para descargar desde internet
instalar_paquete build-essential             # instala gcc, g++...
instalar_paquete python3                     # python
instalar_paquete alacritty                   # terminal
instalar_paquete zsh                         # shell
instalar_paquete ripgrep                     # dependencia de telescope
instalar_paquete lsd                         # sustituto ls
# Establecemos zsh como shell por defecto
if [[ "$SHELL" != *"zsh" ]]; then
  echo "Cambiando el shell predeterminado a Zsh..."
  chsh -s $(which zsh) $USER
fi

####################################
# Instalamos Nerd Font Jetbrains
####################################

FONT_NAME="JetBrainsMono"
FONT_VERSION="v3.0.2" # Cambia esto si hay una nueva versión disponible
DOWNLOAD_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/${FONT_VERSION}/${FONT_NAME}.zip"
FONT_DIR="$HOME/.local/share/fonts"

# Comprobamos si la fuente esta instalada
if fc-list | grep -iq "$FONT_NAME"; then
  echo "La fuente '$FONT_NAME' ya esta instalada."
else
	# Crear directorio de fuentes si no existe
	mkdir -p "$FONT_DIR"

	# Descargar la fuente
	echo "Descargando ${FONT_NAME} Nerd Font..."
	curl -s -L -o "${FONT_NAME}.zip" "$DOWNLOAD_URL"

	# Verificar si la descarga fue exitosa
	if [ $? -ne 0 ]; then
	  echo "Error al descargar la fuente."
	else
	  # Extraer el archivo ZIP
	  echo "Extrayendo la fuente..."
	  unzip -q "${FONT_NAME}.zip" -d "$FONT_DIR"  
	  # Eliminar el archivo ZIP descargado
	  rm "${FONT_NAME}.zip"  
	  # Actualizar la caché de fuentes
	  echo "Actualizando la caché de fuentes..."
	  fc-cache -fv &>/dev/null  
	  # Verificar la instalación
	  if fc-list | grep -i "JetBrainsMono" > /dev/null 2>&1; then
	    echo "JetBrains Mono Nerd Font se ha instalado correctamente."
	  else
	    echo "Error al instalar JetBrains Mono Nerd Font."
	    exit 1
	  fi
	fi
fi


###################
# Instalamos nvim
###################

# Versión de Neovim a instalar
NEOVIM_VERSION="v0.10.2"

if command -v nvim >/dev/null 2>&1; then
  echo "Neovim ya instalado."
else
  echo "Instalando Neovim."
  # Descargar el archivo comprimido del binario desde GitHub
  echo "Descargando Neovim $NEOVIM_VERSION..."
  curl -LO "https://github.com/neovim/neovim/releases/download/$NEOVIM_VERSION/nvim-linux64.tar.gz"  
  # Extraer el archivo descargado
  tar -xzf nvim-linux64.tar.gz
  # Mover el binario a /opt para su uso global
  sudo mv nvim-linux64 /opt/
  # Crear enlace simbólico para hacerlo accesible desde cualquier lugar
  sudo ln -s /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim
  # Limpiar archivos descargados
  rm nvim-linux64.tar.gz  
  # Verificar instalación
  if command -v nvim >/dev/null 2>&1; then
    echo "Neovim se ha instalado correctamente. Versión:"
    nvim --version
  else
    echo "Hubo un error al instalar Neovim."
  fi
fi

#########################
# Instalamos oh-my-zsh
#########################

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  # Variables para evitar interacciones durante la instalación
  export RUNZSH=no
  export CHSH=no

  # Descargar e instalar Oh My Zsh sin interacción
  echo "Instalando Oh My Zsh de forma silenciosa..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

  # Cambiar el shell por defecto a zsh manualmente sin interacción
  sudo chsh -s $(which zsh) $USER
else
  echo "Oh-my-zsh ya instalado."
fi 

#########################
# Fondo de pantalla
#########################

# Ruta de la imagen que quieres establecer como fondo
WALLPAPER="oasis-retrowave.png"
WALLPAPER_PATH="$HOME/dotfiles/wallpapers/$WALLPAPER"

if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then
  # Cambiar el fondo de pantalla (para modo claro y modo oscuro)
  gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPER_PATH"
  gsettings set org.gnome.desktop.background picture-uri-dark "file://$WALLPAPER_PATH"
  echo "Fondo de pantalla cambiado."
else
  echo "No se puede cambiar el fondo de pantalla. Solo esta soportado el escritorio GNOME."
fi

####################
# Configuraciones
####################
crear_symlink_con_respaldo "$HOME/dotfiles/.zshrc" "$HOME/.zshrc"
crear_symlink_con_respaldo "$HOME/dotfiles/alacritty" "$HOME/.config/alacritty"
crear_symlink_con_respaldo "$HOME/dotfiles/nvim" "$HOME/.config/nvim"
crear_symlink_con_respaldo "$HOME/dotfiles/.gitconfig" "$HOME/.gitconfig"

########################
# Instalar node y npm
########################

if command -v nvm >/dev/null 2>&1; then
  echo "nvm ya instalado."
else
  echo "Instalando nvm."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash -s -- --no-modify-zshrc
fi

if command -v node >/dev/null 2>&1; then
  echo "node ya instalado."
else
  echo "Instalando node."
  nvm install 22
fi

########################
# Instalar rust y cargo
########################

if command -v rustc >/dev/null 2>&1; then
  echo "Rust ya instalado."
else
  echo "Instalando Rust."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

# Añadir Rust al PATH para la sesión actual
source "$HOME/.cargo/env"
