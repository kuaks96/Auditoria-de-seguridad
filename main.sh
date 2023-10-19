#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"


#Auditoria de seguridad 

echo -e "\n${blueColour}Comprobacion de configuracion de seguridad....${endColour}"

# Actualizacion del sistema

echo -e "\n${redColour}1. Comprobando actualizaciones del sistema...${endColour}"
sudo pacman -Syu > /dev/null 2>&1
if [ $? -eq 0 ]; then
  sudo pacman -Qu >> result.txt
fi

# Usuarios y grupo

echo -e "\n${grayColourColour}2. Comprobando usuarios y grupos...${endColour}"
awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd >> result.txt


# Servicios en ejecucion
echo -e "\n${purpleColour}3. Comprobando servicios en ejecucion....${endColour}"
sudo systemctl list-units --type=service --state=running >> result.txt

# Puertos abiertos

echo -e "\n${turquoiseColour}4. Comprobando puertos abiertos....${endColour}"
sudo netstat -tunl >> result.txt

# Firewall

echo -e "\n${yellowColour}5. Comprobando reglas de Firewall${endColour}"
sudo iptables -L >> result.txt

# Logs de autenticacion

echo -e "\n${greenColour}6. Comprobando logs de autenticacion....${endColour}"
cat /var/log/pacman.log >> result.txt



echo -e "\n${turquoiseColour}Auditoria de seguridad finalizada${endColour}
