#!/bin/bash
clear

RED="\e[31m";
GREEN="\e[32m";
YELLOW="\e[33m";
IBGGREEN="\e[1;102m"
PLAIN="\e[0m";

if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Skrip perlu dijalankan sebagai root!${PLAIN}"; exit 1
fi

ALAMATHOS=$( cat /etc/hostname );
function webserv {
  if [[ ! -d /tmp/backup ]]; then
    mkdir /tmp/backup
  fi
  cp /etc/group /tmp/backup/
  cp /etc/passwd /tmp/backup/
  cp /etc/shadow /tmp/backup/
  cp /etc/gshadow /tmp/backup

  zip /tmp/backup.zip /tmp/backup
  cp /tmp/backup.zip /var/www/html/backup.zip
  rm -r /tmp/backup && rm -f /tmp/backup.zip

  echo -e "${IBGBLUE}            [ SERVER ] BACKUP            ${PLAIN}"
  echo -e "${YELLOW}Kami sudah selesai dengan proses sandaran.${PLAIN}"
  echo -e "Pautan fail: ${GREEN}http://$ALAMATHOS/backup.zip${PLAIN}"
  echo -e "${IBGBLUE} COPYRIGHT JOKERVPN, POWERED BY CYBERTIZE. ${PLAIN}"
}
webserv
