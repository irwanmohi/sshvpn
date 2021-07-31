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

echo -e "${IBGBLUE}             [ SERVICE ] DETAIL             ${PLAIN}"
echo -e "${YELLOW}Maaf, kami masih dalam pembinaan.${PLAIN}"
echo -e "${IBGBLUE} COPYRIGHT JOKERVPN, POWERED BY CYBERTIZE. ${PLAIN}"
