#!/bin/bash
clear

if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Skrip perlu dijalankan sebagai root!${PLAIN}"; exit 1
fi

echo -e "${IBGBLUE}           [ SERVER ] RESTORE          ${PLAIN}"
read -p "Masukkan pautan fail sandaran: " FILEURL
wget -O /root/backup.zip "${FILEURL}" &>/dev/null
unzip backup.zip

cp backup/passwd /etc/
cp backup/group /etc/
cp backup/shadow /etc/
cp backup/gshadow /etc/

rm -rf /root/backup && rm -f backup.zip
echo -e "${IBGBLUE} COPYRIGHT JOKERVPN, POWERED BY CYBERTIZE. ${PLAIN}"
