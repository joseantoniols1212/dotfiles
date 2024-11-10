#!/bin/bash
# Archivo de instalacion de mi configuracion (para ubuntu)

# Versión de Neovim a instalar
NEOVIM_VERSION="v0.10.2"

# Función para comprobar e instalar un paquete por apt
instalar_paquete() {
  local PAQUETE=$1

  # Comprobar si el paquete ya está instalado
  if dpkg -l | grep -qw "$PAQUETE"; then
    echo "El paquete '$PAQUETE' ya está instalado."
  else
    echo "El paquete '$PAQUETE' no está instalado. Procediendo con la instalación..."
    sudo apt install -y "$PAQUETE"

    # Verificar si la instalación fue exitosa
    if dpkg -l | grep -qw "$PAQUETE"; then
      echo "El paquete '$PAQUETE' se instaló correctamente."
    else
      echo "Hubo un problema al instalar el paquete '$PAQUETE'."
      return 1
    fi
  fi
}

# Actualizamos repositorios y paquetes
sudo apt update
sudo apt upgrade

# Instalamos paquetes
instalar_paquete git
instalar_paquete curl
instalar_paquete build-essential
instalar_paquete python3
instalar_paquete kitty
instalar_paquete zsh
# Establecemos zsh como shell por defecto
echo "Cambiando el shell predeterminado a Zsh..."
chsh -s $(which zsh)

# Instalamos nvim
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

# Instalamos oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"