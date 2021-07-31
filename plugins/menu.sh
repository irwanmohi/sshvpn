#!/bin/bash
clear

RED="\e[31m"
GREEN="\e[32m"
PURPLE="\e[35m"
YELLOW="\e[33m"
CYAN="\e[36m"
IBGBLUE="\e[1;104m"
PLAIN="\e[0m"

GETIP=$( wget -qO- icanhazip.com );
GETHOST=$( cat /etc/hostname );

if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Skrip perlu dijalankan sebagai root!${PLAIN}"; exit 1
fi

. /etc/os-release
echo ""
echo -e "${PURPLE} ╦╔═╗╦╔═╔═╗╦═╗╦  ╦╔═╗╔╗╔${PLAIN}  OS: ${CYAN}Debian $VERSION_ID${PLAIN}";
echo -e "${PURPLE} ║║ ║╠╩╗║╣ ╠╦╝╚╗╔╝╠═╝║║║${PLAIN}  IP: ${CYAN}$GETIP${PLAIN}";
echo -e "${PURPLE}╚╝╚═╝╩ ╩╚═╝╩╚═ ╚╝ ╩  ╝╚╝${PLAIN}  HOST: ${CYAN}$GETHOST${PLAIN}";
echo -e "${IBGBLUE}            [ SSH & OVPN MENU ]            ${PLAIN}"
echo -e "[01] ${YELLOW}trial${PLAIN}      ${GREEN}Jana akaun percubaan untuk sehari${PLAIN}"
echo -e "[02] ${YELLOW}create${PLAIN}     ${GREEN}Buat akaun pengguna untuk sshd & ovpn${PLAIN}"
echo -e "[03] ${YELLOW}renew${PLAIN}      ${GREEN}Tambah tempoh masa aktif akaun pengguna${PLAIN}"
echo -e "[04] ${YELLOW}login${PLAIN}      ${GREEN}Senaraikan pengguna yang log masuk${PLAIN}"
echo -e "[05] ${YELLOW}lists${PLAIN}      ${GREEN}Senaraikan semua akaun pengguna${PLAIN}"
echo -e "[06] ${YELLOW}limit${PLAIN}      ${GREEN}Senaraikan akaun log masuk berganda${PLAIN}"
echo -e "[07] ${YELLOW}kick${PLAIN}       ${GREEN}Tendang pengguna multilogin${PLAIN}"
echo -e "[08] ${YELLOW}kill${PLAIN}       ${GREEN}Hentikan pengguna multilogin${PLAIN}"
echo -e "[09] ${YELLOW}unlock${PLAIN}     ${GREEN}Buka kunci atau dayakan akaun pengguna${PLAIN}"
echo -e "[10] ${YELLOW}lock${PLAIN}       ${GREEN}Kunci atau nyahdayakan akaun pengguna${PLAIN}"
echo -e "[11] ${YELLOW}delete${PLAIN}     ${GREEN}Padamkan akaun pengguna${PLAIN}"
echo ""
echo -e "${IBGBLUE}             [ SERVICE  MENU ]             ${PLAIN}"
echo -e "[12] ${YELLOW}check${PLAIN}      ${GREEN}Semak perkhidmatan${PLAIN}"
echo -e "[13] ${YELLOW}detail${PLAIN}     ${GREEN}Perincian perkhidmatan${PLAIN}"
echo -e "[14] ${YELLOW}ports${PLAIN}      ${GREEN}Tukar port perkhidmatan${PLAIN}"
echo -e "[15] ${YELLOW}restart${PLAIN}    ${GREEN}Mulakan semula perkhidmatan${PLAIN}"
echo ""
echo -e "${IBGBLUE}              [ SERVER MENU ]              ${PLAIN}"
echo -e "[16] ${YELLOW}domain${PLAIN}     ${GREEN}Tambah sub/domain${PLAIN}"
echo -e "[17] ${YELLOW}backup${PLAIN}     ${GREEN}Data sandaran${PLAIN}"
echo -e "[18] ${YELLOW}restore${PLAIN}    ${GREEN}Pulihkan data${PLAIN}"
echo -e "[19] ${YELLOW}speed${PLAIN}      ${GREEN}Uji kelajuan pelayan${PLAIN}"
echo -e "[20] ${YELLOW}detail${PLAIN}     ${GREEN}Perincian pelayan${PLAIN}"
echo -e "[21] ${YELLOW}reboot${PLAIN}     ${GREEN}Mulakan semula pelayan${PLAIN}"
echo ""
echo -e "[00] ${YELLOW}exit${PLAIN}       ${GREEN}EXIT FROM MENU${PLAIN}"
echo -e "${IBGBLUE} COPYRIGHT JOKERVPN, POWERED BY CYBERTIZE. ${PLAIN}"
read -p "Sila masukkan pilihan anda: " MENUCHOICE

while true; do
  case $MENUCHOICE in
    01|trial )
      bash /usr/local/bin/trial_user.sh
      break
    ;;
    02|create )
      bash /usr/local/bin/create_user.sh
      break
    ;;
    03|renew )
      bash /usr/local/bin/renew_user.sh
      break
    ;;
    04|login )
      bash /usr/local/bin/login_user.sh
      break
    ;;
    05|lists )
      bash /usr/local/bin/lists_user.sh
      break
    ;;
    06|limit )
      bash /usr/local/bin/limit_user.sh
      break
    ;;
    07|kick )
      bash /usr/local/bin/kick_user.sh
      break
    ;;
    08|kill )
      bash /usr/local/bin/kill_user.sh
      break
    ;;
    09|unlock )
      bash /usr/local/bin/unlock_user.sh
      break
    ;;
    10|lock )
      bash /usr/local/bin/lock_user.sh
      break
    ;;
    11|delete )
      bash /usr/local/bin/delete_user.sh
      break
    ;;
    12|check )
      bash /usr/local/bin/check_service.sh
      break
    ;;
    13|detail )
      bash /usr/local/bin/detail_service.sh
      break
    ;;
    14|ports )
      bash /usr/local/bin/ports_service.sh
      break
    ;;
    15|restart )
      bash /usr/local/bin/restart_service.sh
      break
    ;;
    16|domain )
      bash /usr/local/bin/domain_server.sh
      break
    ;;
    17|backup )
      bash /usr/local/bin/backup_server.sh
      break
    ;;
    18|restore )
      bash /usr/local/bin/restore_server.sh
      break
    ;;
    19|speed )
      bash /usr/local/bin/speedtest
      break
    ;;
    20|detail )
      bash /usr/local/bin/detail_server.sh
      break
    ;;
    21|reboot )
      bash /usr/local/bin/reboot_server.sh
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
