# dotfiles

## Dependencias

Instalar GNU stow.

Instalar los programas correspondientes a las configuraciones i3 , polybar, nvim, picom, alacritty.
Para el fondo de escritorio es necesario instalar feh.

## Uso

Clonar este repositorio en $HOME.

```
git clone https://github.com/joseantoniols1212/dotfiles.git
```

Ejecutar el siguiente código de stow:
```
stow */
```
(Esto ejecutará stow tomando como parámetros solo las carpetas).

## ¿Cómo añadir más archivos?

Crear carpeta para segmentar los archivos que buscamos añadir. Y simular que dicha carpeta es $HOME, de manera que recreamos el path de donde queremos que se encuentren finalmente los archivos.

Ejemplo:

Buscamos añadir la carpeta alacritty que contiene la configuración deseada (podría tratarse directamente de un archivo) y su ubicación debe ser `$HOME/.config/alacritty`.

Entonces guardamos alacritty en el siguiente directorio: `$HOME/dotfiles/alacritty/.config/alacritty`.
