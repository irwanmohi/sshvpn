#!/bin/bash
clear

RED="\e[31;1m";
GREEN="\e[32;1m";
YELLOW="\e[33;1m";
IBGGREEN="\e[1;102m"
PLAIN="\e[0m";

if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Skrip perlu dijalankan sebagai root!${PLAIN}"; exit 1
fi

read -p "Adakah anda pasti mahu mula semula sistem? [Y/n]: " YESNO
if [[ "$YESNO" = "Y" ]] || [[ "$YESNO" = "y" ]]; then
  echo -e "${IBGBLUE}             [ SERVER ] REBOOT             ${PLAIN}"
  echo "Kami akan mula semula sistem anda sekarang, Bye..." && reboot
  echo -e "${IBGBLUE} COPYRIGHT JOKERVPN, POWERED BY CYBERTIZE. ${PLAIN}"
fi