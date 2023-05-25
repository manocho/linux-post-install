#!/bin/sh

# Actualizar sources.list para sumar repositorios contrib y non-free
if ! grep -q "contrib" /etc/apt/sources.list || ! grep -q "non-free" /etc/apt/sources.list; then
    # Add the "contrib" and "non-free" options to the sources.list file
    sudo sed -i 's/main/main contrib non-free/g' /etc/apt/sources.list
    echo "Opciones 'contrib' y 'non-free' agregadas a sources.list"
else
    echo "'contrib' y 'non-free' ya existen, no se modifica el archivo"
fi

# Actualizando el sistema
sudo apt update && sudo apt -y upgrade

# Instalando paquetes base11
sudo apt install mc htop net-tools firmware-realtek firmware-misc-nonfree

# Instalando docker
sudo apt-get install ca-certificates curl gnupgfile_location="/usr/src/node-red/node_modules/node-red/settings.js"
