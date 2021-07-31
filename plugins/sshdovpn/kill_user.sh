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

if [[ -f /usr/local/bin/kill_user.sh ]]; then
  cp /usr/share/plugins/sshdovpn/kill_user.sh /usr/local/bin/kill_user.sh
  chmod +x /usr/local/bin/kill_user.sh
fi
echo -e "${IBGBLUE}      [ SSHD & OVPN ] KILL MULTI LOGIN      ${PLAIN}"
echo -e "[01] ${GREEN}Tetapkan auto kill 2 Minutes${PLAIN}"
echo -e "[02] ${GREEN}Tetapkan auto kill 5 Minutes${PLAIN}"
echo -e "[03] ${GREEN}Tetapkan auto kill 9 Minutes${PLAIN}"
echo -e "[04] ${GREEN}Matikan auto kill${PLAIN}"
echo -e "[05] ${GREEN}Kembali ke menu utama${PLAIN}"
echo -e "[00] ${GREEN}Keluar dari menu${PLAIN}"
echo -e "${IBGBLUE} COPYRIGHT JOKERVPN, POWERED BY CYBERTIZE. ${PLAIN}"
read -p "Sila masukkan pilihan anda: " MENUCHOICE

case $MENUCHOICE in
  01)
    clear
    rm -f /etc/cron.d/autokill
    echo "*/2 * * * *  root /usr/local/bin/kill_user.sh" > /etc/cron.d/autokill
    echo -e "${IBGBLUE}      MULTI LOGIN      ${PLAIN}"
    echo -e "Allowed MultiLogin : 2"
    echo -e "AutoKill Every     : 2 Minutes"
    echo -e "${IBGBLUE} COPYRIGHT JOKERVPN. ${PLAIN}"
    exit
  ;;
  02)
    clear
    rm -f /etc/cron.d/autokill
    echo "*/5 * * * *  root /usr/local/bin/kill_user.sh" > /etc/cron.d/autokill
    echo -e "${IBGBLUE}      MULTI LOGIN      ${PLAIN}"
    echo -e "Allowed MultiLogin : 2"
    echo -e "AutoKill Every     : 5 Minutes"
    echo -e "${IBGBLUE} COPYRIGHT JOKERVPN. ${PLAIN}"
    exit
  ;;
  03)
    clear
    rm -f /etc/cron.d/autokill
    echo "*/9 * * * *  root /usr/local/bin/kill_user.sh" > /etc/cron.d/autokill
    echo -e "${IBGBLUE}      MULTI LOGIN      ${PLAIN}"
    echo -e "Allowed MultiLogin : 2"
    echo -e "AutoKill Every     : 9 Minutes"
    echo -e "${IBGBLUE} COPYRIGHT JOKERVPN. ${PLAIN}"
    exit
  ;;
  04)
    clear
    rm -f /etc/cron.d/autokill
    echo -e ""
    echo -e "${IBGBLUE}      MULTI LOGIN      ${PLAIN}"
    echo -e "AutoKill MultiLogin Turned Off  "
    echo -e "${IBGBLUE} COPYRIGHT JOKERVPN. ${PLAIN}"
    exit
  ;;
  05 )
    bash /usr/local/bin/menu
    break
  ;;
  00 )
    exit 0
  ;;
esac
