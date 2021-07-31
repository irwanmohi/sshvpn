#!/bin/bash
clear

RED="\e[0;31m"
GREEN="\e[0;32m"
YELLOW="\e[33m"
IBGBLUE="\e[1;104m"
PLAIN="\e[0m"

if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Skrip perlu dijalankan sebagai root!${PLAIN}"; exit 1
fi

echo -e "${IBGBLUE}        [ SSHD & OVPN ] CHECK LIMIT        ${PLAIN}"
if [ -e "/root/log-limit.txt" ]; then
  echo "Waktu - Nama pengguna - Jumlah logmasuk"
  cat /root/log-limit.txt
else
  echo -e "${YELLOW}Empty...${PLAIN} atau ${RED}skrip limit_user belum dijalankan${PLAIN}."
fi
echo -e "${IBGBLUE} COPYRIGHT JOKERVPN, POWERED BY CYBERTIZE. ${PLAIN}"