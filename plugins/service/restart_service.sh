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

ALAMATHOS=$( cat /etc/hostname );
echo -e "${IBGBLUE}         [ MULA SEMULA PERKHIDMATAN ]         ${PLAIN}"
echo -e "[01] all         ${GREEN}Memulakan semula semua perkhidmatan${PLAIN}"
echo -e "[02] sshd        ${GREEN}Mulakan semula perkhidmatan ssh${PLAIN}"
echo -e "[03] dropbear    ${GREEN}Mulakan semula perkhidmatan dropbear${PLAIN}"
echo -e "[04] openvpn     ${GREEN}Mulakan semula perkhidmatan openvpn${PLAIN}"
echo -e "[05] squid       ${GREEN}Mulakan semula perkhidmatan squid${PLAIN}"
echo -e "[06] stunnel     ${GREEN}Mulakan semula perkhidmatan stunnel${PLAIN}"
echo -e "[07] badvpn      ${GREEN}Mulakan semula perkhidmatan badvpn${PLAIN}"
echo -e "[08] nginx       ${GREEN}Mulakan semula perkhidmatan nginx${PLAIN}"
echo -e "[09] webmin      ${GREEN}Mulakan semula perkhidmatan webmin${PLAIN}"
echo -e "[10] back        ${GREEN}Kembali ke menu utama${PLAIN}"
echo -e "[00] exit        ${GREEN}Keluar dari menu${PLAIN}"
echo -e ""
read -p "Sila masukkan pilihan anda: " CHOOSEMENU

case $CHOOSEMENU in
  01|all )
    echo -e "${IBGBLUE}           [ SERVICES ] RESTART           ${PLAIN}";
    echo -n "Sila tunggu, memulakan semula perkhidmatan..."
    systemctl restart ssh &>/dev/null
    systemctl restart dropbear &>/dev/null
    systemctl restart openvpn &>/dev/null
    systemctl restart squid &>/dev/null
    systemctl restart stunnel4 &>/dev/null
    systemctl restart badvpn-udpgw &>/dev/null
    systemctl restart nginx &>/dev/null
    systemctl restart webmin &>/dev/null
    echo -e "${GREEN}[ Selesai ]${PLAIN}";
    echo -e "${IBGBLUE} COPYRIGHT JOKERVPN, POWERED BY CYBERTIZE. ${PLAIN}";
    break
  ;;
  02|sshd )
    echo -e "${IBGBLUE}         [ SERVICES ] RESTART SSHD         ${PLAIN}";
    echo -n "Sila tunggu, memulakan semula perkhidmatan ssh..."
    systemctl restart ssh &>/dev/null
    echo -e "${GREEN}[ Selesai ]${PLAIN}";
    echo -e "${IBGBLUE} COPYRIGHT JOKERVPN, POWERED BY CYBERTIZE. ${PLAIN}";
    break
  ;;
  03|dropbear)
    echo -e "${IBGBLUE}       [ SERVICES ] RESTART DROPBEAR       ${PLAIN}";
    echo -n "Sila tunggu, memulakan semula perkhidmatan dropbear..."
    systemctl restart dropbear &>/dev/null
    echo -e "${GREEN}[ Selesai ]${PLAIN}";
    echo -e "${IBGBLUE} COPYRIGHT JOKERVPN, POWERED BY CYBERTIZE. ${PLAIN}";
    break
  ;;
  04|openvpn )
    echo -e "${IBGBLUE}        [ SERVICES ] RESTART OPENVPN       ${PLAIN}";
    echo -n "Sila tunggu, memulakan semula perkhidmatan openvpn..."
    systemctl restart openvpn &>/dev/null
    echo -e "${GREEN}[ Selesai ]${PLAIN}";
    echo -e "${IBGBLUE} COPYRIGHT JOKERVPN, POWERED BY CYBERTIZE. ${PLAIN}";
    break
  ;;
  05|squid )
    echo -e "${IBGBLUE}         [ SERVICES ] RESTART SQUID        ${PLAIN}";
    echo -n "Sila tunggu, memulakan semula perkhidmatan squid..."
    systemctl restart squid &>/dev/null
    echo -e "${GREEN}[ Selesai ]${PLAIN}";
    echo -e "${IBGBLUE} COPYRIGHT JOKERVPN, POWERED BY CYBERTIZE. ${PLAIN}";
    break
  ;;
  06|stunnel )
    echo -e "${IBGBLUE}        [ SERVICES ] RESTART STUNNEL       ${PLAIN}";
    echo -n "Sila tunggu, memulakan semula perkhidmatan stunnel..."
    systemctl restart stunnel4 &>/dev/null
    echo -e "${GREEN}[ Selesai ]${PLAIN}";
    echo -e "${IBGBLUE} COPYRIGHT JOKERVPN, POWERED BY CYBERTIZE. ${PLAIN}";
    break
  ;;
  07|badvpn )
    echo -e "${IBGBLUE}        [ SERVICES ] RESTART BADVPN        ${PLAIN}";
    echo -n "Sila tunggu, memulakan semula perkhidmatan badvpn..."
    systemctl restart badvpn-udpgw &>/dev/null
    echo -e "${GREEN}[ Selesai ]${PLAIN}";
    echo -e "${IBGBLUE} COPYRIGHT JOKERVPN, POWERED BY CYBERTIZE. ${PLAIN}";
    break
  ;;
  08|nginx )
    echo -e "${IBGBLUE}         [ SERVICES ] RESTART NGINX        ${PLAIN}";
    echo -n "Sila tunggu, memulakan semula perkhidmatan nginx..."
    systemctl restart nginx &>/dev/null
    echo -e "${GREEN}[ Selesai ]${PLAIN}";
    echo -e "${IBGBLUE} COPYRIGHT JOKERVPN, POWERED BY CYBERTIZE. ${PLAIN}";
    break
  ;;
  09|webmin )
    echo -e "${IBGBLUE}        [ SERVICES ] RESTART WEBMIN        ${PLAIN}";
    echo -n "Sila tunggu, memulakan semula perkhidmatan webmin..."
    systemctl restart webmin &>/dev/null
    echo -e "${GREEN}[ Selesai ]${PLAIN}";
    echo -e "${IBGBLUE} COPYRIGHT JOKERVPN, POWERED BY CYBERTIZE. ${PLAIN}";
    break
  ;;
  10|back )
    bash /usr/local/bin/menu
  ;;
  00|exit)
    exit
  ;;
esac