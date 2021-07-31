#!/bin/bash
clear

RED="\e[0;31m"
GREEN="\e[0;32m"
IBGBLUE="\e[1;104m"
PLAIN="\e[0m"

if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Skrip perlu dijalankan sebagai root!${PLAIN}"; exit 1
fi

read -p "[UNLOCK] Masukkan nama pengguna: " NAMAPENGGUNA
egrep "^$NAMAPENGGUNA" /etc/passwd &>/dev/null
if [ $? -ne 0 ]; then
  echo -e "${RED}\U1F6AB Nama pengguna tidak ditemukan!${PLAIN}";
  exit 2
fi
passwd -u $NAMAPENGGUNA
echo -e "${IBGBLUE}        [ SSHD & OVPN ] UNLOCK USER        ${PLAIN}"
echo -e "${GREEN}Berjaya buka kunci akaun pengguna.${PLAIN}"
echo -e "${IBGBLUE} COPYRIGHT JOKERVPN, POWERED BY CYBERTIZE. ${PLAIN}"
echo ""