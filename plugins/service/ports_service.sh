#!/bin/bash
clear

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
IBGBLUE="\e[1;104m"
PLAIN="\e[0m"

if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Skrip perlu dijalankan sebagai root!${PLAIN}"; exit 1
fi

function dropbear {
  local OLDPORT=$( grep 'DROPBEAR_PORT' /etc/default/dropbear | cut -d '=' -f 2 );
  read -rp "Change dropbear port? [Y/n] " YESNO
  if [[ ! $YESNO =~ ^[Yy]$ ]]; then
    exit 1
  else
    until [[ $DROPBEARPORT =~ ^[0-9]+$ ]]; do
      echo -e "${YELLOW}Note: Please make sure that port is unused,${PLAIN}"
      echo -e "${YELLOW}used port for dropbear now is${PLAIN}: ${GREEN}$OLDPORT${PLAIN}"
      read -rp "Enter new port [1-65535]: " NEWPORT
      sed -i "s/$OLDPORT/$NEWPORT/" /etc/default/dropbear
    done
  fi
}

function openvpn {
  local OLDPORT=$( grep 'port' /etc/openvpn/server.conf | cut -d ' ' -f 2 );
  local CLIENTPORT=$( grep 'remote' /etc/openvpn/client/custom.ovpn | head -1 | cut -d ' ' -f 3 );
  read -rp "Change openvpn port? [Y/n] " YESNO
  if [[ ! $YESNO =~ ^[Yy]$ ]]; then
    exit 1
  else
    until [[ $SERVPORT =~ ^[0-9]+$ ]]; do
      echo -e "${YELLOW}Note: Please make sure that port is unused,${PLAIN}"
      echo -e "${YELLOW}used port for openvpn now is${PLAIN}: ${GREEN}$SERVPORT${PLAIN}"
      read -rp "Enter new port [1-65535]: " NEWPORT
      sed -i "s/$SERVPORT/$NEWPORT/" /etc/openvpn/server.conf
      sed -i "s/$CLIENTPORT/$NEWPORT/" /etc/openvpn/client/custom.ovpn
    done
  fi
}

function squid {
  local OLDPORT=$( grep 'http_port' /etc/squid/squid.conf | cut -d ' ' -f 2 );
  read -rp "Change squid port? [Y/n] " YESNO
  if [[ ! $YESNO =~ ^[Yy]$ ]]; then
    exit 1
  else
    until [[ $OLDPORT =~ ^[0-9]+$ ]]; do
      echo -e "${YELLOW}Note: Please make sure that port is unused,${PLAIN}"
      echo -e "${YELLOW}used port for squid now is${PLAIN}: ${GREEN}$OLDPORT${PLAIN}"
      read -rp "Enter new port [1-65535]: " NEWPORT
      sed -i "s/$OLDPORT/$NEWPORT/" /etc/squid/squid.conf
    done
  fi
}

echo -e "${IBGBLUE}             [ SERVICE ] PORTS             ${PLAIN}"
echo -e "[01] dropbear     ${GREEN}Ganti port dropbear${PLAIN}"
echo -e "[02] openvpn      ${GREEN}Ganti port openvpn${PLAIN}"
echo -e "[03] squid        ${GREEN}Ganti port squid${PLAIN}"
echo -e "[04] stunnel      ${GREEN}Ganti port stunnel${PLAIN}"
echo -e "[05] libev        ${GREEN}Ganti port ss-libev${PLAIN}"
echo -e "[06] v2ray        ${GREEN}Ganti port v2ray${PLAIN}"
echo -e "[07] wireguard    ${GREEN}Ganti port wireguard${PLAIN}"
echo -e "[08] back         ${GREEN}Kembali ke menu utama${PLAIN}"
echo -e "[00] exit         ${GREEN}Keluar dari menu${PLAIN}"
echo -e "${IBGBLUE} COPYRIGHT JOKERVPN, POWERED BY CYBERTIZE. ${PLAIN}"
read -p "Sila masukkan pilihan anda: " MENUCHOICE

while true ; do
  case $MENUCHOICE in
    01|dropbear )
      dropbear
      break
    ;;
    02|openvpn )
      openvpn
      break
    ;;
    03|squid )
      squid
      break
    ;;
    04|stunnel )
      echo -e "${RED}Maaf, kami masih dalam pembinaan!${PLAIN}"
      break
    ;;
    05|libev )
      echo -e "${RED}Maaf, kami masih dalam pembinaan!${PLAIN}"
      break
    ;;
    06|v2ray )
      echo -e "${RED}Maaf, kami masih dalam pembinaan!${PLAIN}"
      break
    ;;
    07|wireguard )
      echo -e "${RED}Maaf, kami masih dalam pembinaan!${PLAIN}"
      break
    ;;
    08|back )
      bash /usr/share/plugins/server/_menu
      break
    ;;
    00|exit )
      clear && exit 0
    ;;
    * )
      echo -e "${RED}Pilihan yang anda masukkan tidak sah!${PLAIN}"
      exit 2
    ;;
  esac
done
