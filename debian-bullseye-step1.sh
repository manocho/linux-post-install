#!/bin/bash

# DISTRO = DEBIAN BULLSEYE
# Primero verifico que la versión es la correcta

distroname=$(lsb_release -is)
codename=$(lsb_release -cs)

# Check if the distribution is Bullseye (Debian 11)
if [[ $codename == "bullseye" ]]; then
    clear
    # Execute the command for Bullseye
    echo -e "----------------------------------"
    echo -e "\nEjecutando script post-install"
    echo -e "$distroname: $codename\n"
    echo -e "----------------------------------\n"

    # Add your desired command here
else
    # Distribution is not Bullseye
    echo "ERROR: este script está diseñado para Debian Bullseye (Debian 11)."
    exit 1
fi

# Actualizar sources.list para sumar repositorios contrib y non-free
echo -e "** Actualizando sources.list **\n"
if ! grep -q "contrib" /etc/apt/sources.list || ! grep -q "non-free" /etc/apt/sources.list; then
    # Add the "contrib" and "non-free" options to the sources.list file
    sudo sed -i 's/main/main contrib non-free/g' /etc/apt/sources.list
    echo "Opciones 'contrib' y 'non-free' agregadas a sources.list"
else
    echo "'contrib' y 'non-free' ya existen, no se modifica el archivo"
fi

echo -e "** Actualizando repositorios **\n"
sudo apt-get update && sudo apt -y upgrade

# Instalando paquetes base1
echo -e "** Instalando paquetes base **\n"
sudo apt-get -y install mc htop net-tools firmware-realtek firmware-misc-nonfree

# Instalando docker
echo -e "** Instalando docker **\n"
sudo apt-get -y install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
