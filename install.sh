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

crear_symlink() {
  local origen=$1
  local destino=$2

  rm -r $destino
  # Crear el symlink
  ln -s "$origen" "$destino"
  echo "Symlink creado: $destino -> $origen"
}

########################################
# Actualizamos repositorios y paquetes
########################################
echo "Actualizando repositorios y paquetes"
sudo apt-get update
sudo apt-get upgrade

####################################
# Instalamos paquetes generales
####################################
instalar_paquete git                         # git
instalar_paquete curl                        # herramienta para descargar desde internet
instalar_paquete build-essential             # instala gcc, g++...
instalar_paquete python3                     # python
instalar_paquete alacritty                   # terminal
instalar_paquete zsh                         # shell
instalar_paquete lsd                         # sustituto ls
instalar_paquete xclip                       # clipboard
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
crear_symlink "$HOME/dotfiles/.zshrc" "$HOME/.zshrc"
crear_symlink "$HOME/dotfiles/alacritty" "$HOME/.config/alacritty"
crear_symlink "$HOME/dotfiles/.gitconfig" "$HOME/.gitconfig"