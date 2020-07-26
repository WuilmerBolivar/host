#!/bin/bash
#-------------------------------
# Host | Version - 2.0
# Expose Your LocalHost
#-------------------------------
# Created By TAHMID RAYAT
# Github : https://github.com/htr-tech
# Instagram : https://www.instagram.com/tahmid.rayat
#-----------------------------------------------------
#-------------------------------
# Traducido by Wuilmer Bolivar
# Github : https://github.com/WuilmerBolivar
# Facebook : https://www.facebook.com/BolivarWuilmer
#-----------------------------------------------------

# If you Copy Then Give me The Credits

trap 'printf "\n";stop;exit 1' 2
trap user_interrupt SIGINT
trap user_interrupt SIGTSTP

user_interrupt(){
        printf "\e[0m\n"
        printf "\e[0m\e[1;36m\t Interumpiendo!!\n"
        sleep 2
        printf "\e[0m\n"
        exit 1
}

deps() {
command -v php > /dev/null 2>&1 || { echo >&2 "PHP no esta instalado! Instalarlo."; exit 1; }
command -v curl > /dev/null 2>&1 || { echo >&2 "Curl no esta instalado! Instalarlo."; exit 1; }
command -v ssh > /dev/null 2>&1 || { echo >&2 "Openssh no esta instalado! Instalarlo."; exit 1; }
command -v unzip > /dev/null 2>&1 || { echo >&2 "Unzip no esta instalado! Instalarlo-"; exit 1; }
}

stop() {
checkngrok=$(ps aux | grep -o "ngrok" | head -n1)
checkphp=$(ps aux | grep -o "php" | head -n1)
checkssh=$(ps aux | grep -o "ssh" | head -n1)

if [[ $checkngrok == *'ngrok'* ]]; then
pkill -f -2 ngrok > /dev/null 2>&1
killall -2 ngrok > /dev/null 2>&1
fi
if [[ $checkphp == *'php'* ]]; then
pkill -f -2 php > /dev/null 2>&1
killall -2 php > /dev/null 2>&1
fi
if [[ $checkssh == *'ssh'* ]]; then
pkill -f -2 ssh > /dev/null 2>&1
killall ssh > /dev/null 2>&1
fi
if [[ -e linksender ]]; then
rm -rf linksender
fi
}

sleep 3s; echo "Verificar el servicio HTTP"
SERVICE='httpd'
if ps ax | grep -v grep | grep $SERVICE > /dev/null
then
echo "--------------------------------------------"
echo "$SERVICE ejecutandose..."
echo "--------------------------------------------"
else
echo "$SERVICE esta detenido. (ojo)"
echo "--------------------------------------------"
fi

sleep 5s; echo "Verificar el servicio SSH"
SERVICE2='ssh'
if ps ax | grep -v grep | grep $SERVICE2 > /dev/null
then
echo "$SERVICE2 ejecutandose..."
echo "--------------------------------------------"
else
echo "$SERVICE2 esta detenido."
echo "--------------------------------------------"
fi

banner(){
printf "\e[1;33m     _    _           _   \e[0m\n"
printf "\e[1;33m    | |  | | \e[0m\e[1;36m V-2.5\e[0m\e[1;33m  | |  \e[0m\n"
printf "\e[1;33m    | |__| | ___  ___| |_ \e[0m\n"
printf "\e[1;33m    |  __  |/ _ \/ __| __|\e[0m\n"
printf "\e[1;33m    | |  | | (_) \__ \ |_ \e[0m\n"
printf "\e[1;33m    |_|  |_|\___/|___/\__|\e[0m\n"
printf "\n"
printf "\e[1;31m [\e[0m\e[1;37m~\e[0m\e[1;31m]\e[0m\e[1;32m Creado por HTR-TECH \e[0m\e[1;31m(\e[0m\e[1;33mTahmid Rayat\e[0m\e[1;31m).\e[0m\n"
printf "\e[1;31m [\e[0m\e[1;37m~\e[0m\e[1;31m]\e[0m\e[1;32m Traducido por Wuilmer Bolivar\e[0m\e[1;31m.\e[0m\n"
printf "\n"
}
menu(){
if [[ -e htdocs ]]; then
echo ""
else
mkdir htdocs
fi
printf "\n"
printf " \e[1;31m[\e[0m\e[1;37m01\e[0m\e[1;31m]\e[0m\e[1;93m Localhost\e[0m\n"
printf "\e[0m\n"
printf " \e[1;31m[\e[0m\e[1;37m02\e[0m\e[1;31m]\e[0m\e[1;93m Ngrok.io\e[0m\n"
printf "\e[0m\n"
printf " \e[1;31m[\e[0m\e[1;37m03\e[0m\e[1;31m]\e[0m\e[1;93m Localhost.run\e[0m\n"
d_o_server="3"
printf "\e[0m\n"
read -p $' \e[1;31m[\e[0m\e[1;37m~\e[0m\e[1;31m]\e[0m\e[1;92m Selecione un servicio: \e[0m\e[1;96m\en' option_server
option_server="${option_server:-${d_o_server}}"

if [[ $option_server == 1 || $option_server == 01 ]]; then
start_l
elif [[ $option_server == 2 || $option_server == 02 ]]; then
start_n
elif [[ $option_server == 3 || $option_server == 03 ]]; then
start_local
else
printf " \e[1;91m[\e[0m\e[1;97m!\e[0m\e[1;91m]\e[0m\e[1;93m Incorrecto \e[1;91m[\e[0m\e[1;97m!\e[0m\e[1;91m]\e[0m\n"
sleep 1
banner
menu
fi
}

start_l() {
def_port="5555"
printf "\e[0m\n"
printf ' \e[1;31m[\e[0m\e[1;37m~\e[0m\e[1;31m]\e[0m\e[1;92m Seleccione un puerto (Defecto:\e[0m\e[1;96m%s\e[0m\e[1;92m): \e[0m\e[1;96m' $def_port
read port
port="${port:-${def_port}}"
printf "\e[0m\n"
printf " \e[1;31m[\e[0m\e[1;37m~\e[0m\e[1;31m]\e[0m\e[1;92m Iniciando...\e[0m\e[1;92m(\e[0m\e[1;96mlocalhost:$port\e[0m\e[1;92m)\e[0m\n"
cd htdocs && php -S 127.0.0.1:$port > /dev/null 2>&1 &
sleep 2
printf "\e[0m\n"
printf " \e[1;31m[\e[0m\e[1;37m~\e[0m\e[1;31m]\e[0m\e[1;92m Hospedado con éxito en:\e[0m\e[1;93m http://localhost:$port\e[0m\n"
found
}

start_n() {
if [[ -e ngrok ]]; then
echo ""
else
printf "\e[0m\n"
printf " \e[1;31m[\e[0m\e[1;37m~\e[0m\e[1;31m]\e[0m\e[1;92m Iniciando...\e[0m\e[1;92m(\e[0m\e[1;96mlocalhost:5555\e[0m\e[1;92m)\e[0m\n"
arch=$(uname -a | grep -o 'arm' | head -n1)
arch2=$(uname -a | grep -o 'Android' | head -n1)
if [[ $arch == *'arm'* ]] || [[ $arch2 == *'Android'* ]] ; then
curl -LO https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip > /dev/null 2>&1
if [[ -e ngrok-stable-linux-arm.zip ]]; then
unzip ngrok-stable-linux-arm.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-arm.zip
else
printf " \e[1;96m[\e[1;97m!\e[1;96m]\e[1;93m Error \e[1;96m[\e[1;97m!\e[1;96m]\e[1;96m Instale todos los paquetes.\e[0m\n"
exit 1
fi
else
curl -LO https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip > /dev/null 2>&1
if [[ -e ngrok-stable-linux-386.zip ]]; then
unzip ngrok-stable-linux-386.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-386.zip
else
printf " \e[1;96m[\e[1;97m!\e[1;96m]\e[1;93m Error \e[1;96m[\e[1;97m!\e[1;96m]\e[1;96m Instale todos los paquetes.\e[0m\n"
exit 1
fi
fi
fi
printf "\e[0m\n"
printf " \e[1;31m[\e[0m\e[1;37m~\e[0m\e[1;31m]\e[0m\e[1;92m Lanzamiento de Ngrok...\e[0m\n"
cd htdocs && php -S 127.0.0.1:5555 > /dev/null 2>&1 &
sleep 2
./ngrok http 5555 > /dev/null 2>&1 &
sleep 7
ngrok_link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
printf "\n \e[1;31m[\e[0m\e[1;37m~\e[0m\e[1;31m]\e[0m\e[1;92m Hospedado con éxito en:\e[0m\e[1;93m %s \n" $ngrok_link
found
}

start_local(){
def_port="5555"
printf "\e[0m\n"
printf ' \e[1;31m[\e[0m\e[1;37m~\e[0m\e[1;31m]\e[0m\e[1;92m Seleccione un puerto (Defecto:\e[0m\e[1;96m%s\e[0m\e[1;92m): \e[0m\e[1;96m' $def_port
read port
port="${port:-${def_port}}"
printf "\e[0m\n"
printf "\e[1;31m[\e[0m\e[1;37m~\e[0m\e[1;31m]\e[0m\e[1;92m Iniciando...\e[0m\e[1;92m(\e[0m\e[1;96mlocalhost:$port\e[0m\e[1;92m)\e[0m\n"
cd htdocs && php -S 127.0.0.1:$port > /dev/null 2>&1 &
sleep 2
printf "\e[0m\n"
printf " \e[1;31m[\e[0m\e[1;37m~\e[0m\e[1;31m]\e[0m\e[1;92m Iniciando LocalHostRun...\e[0m\n"
printf "\n"
if [[ -e linksender ]]; then
rm -rf linksender
fi
printf " \e[1;31m[\e[0m\e[1;37m~\e[0m\e[1;31m]\e[0m\e[1;96m Presione Ctrl + C para salir.\e[0m\n"
printf "\e[1;93m\n"
ssh -R 80:localhost:$port ssh.localhost.run 2>&1
printf "\e[0m\n"
}

found() {
printf "\n"
printf "\n \e[1;31m[\e[0m\e[1;37m~\e[0m\e[1;31m]\e[0m\e[1;96m Presione Ctrl + C para salir.\e[0m\n"
while [ true ]; do
sleep 0.75
done
}
banner
deps
menu