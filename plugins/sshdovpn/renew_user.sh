#!/bin/bash
clear

RED="\e[0;31m"
GREEN="\e[0;32m"
IBGBLUE="\e[1;104m"
PLAIN="\e[0m"

if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Skrip perlu dijalankan sebagai root!${PLAIN}"; exit 1
fi

read -p "Masukkan nama pengguna: " NAMAPENGGUNA
read -p "Tempoh masa aktif (Hari): " TEMPOHAKTIF
egrep "^$NAMAPENGGUNA" /etc/passwd >/dev/null
if [ $? -ne 0 ]; then
  echo -e "${RED}Nama pengguna tidak ditemukan!${PLAIN}";
  exit 2
fi

TANGGAL=$( date +%s )
AKTIFSAAT=$(( $TEMPOHAKTIF * 86400 ))
TAMATTEMPOH=$(( $TANGGAL + $AKTIFSAAT ))
TARIKHLUPUT=$( date -u --date="1970-01-01 $TAMATTEMPOH sec GMT" +%Y/%m/%d )

passwd -u $NAMAPENGGUNA
usermod -e $TARIKHLUPUT $NAMAPENGGUNA
egrep "^$NAMAPENGGUNA" /etc/passwd >/dev/null
# echo -e "$password\n$password" | passwd $NAMAPENGGUNA &>/dev/null

echo -e "${IBGBLUE}        [ SSHD & OVPN ] RENEW USER        ${PLAIN}"
echo -e "Nama pengguna: ${GREEN}$NAMAPENGGUNA${PLAIN}"
echo -e "Tempoh aktif:  ${GREEN}$TEMPOHAKTIF hari${PLAIN}"
echo -e "Tarikh luput:  ${GREEN}$TARIKHLUPUT${PLAIN}"
echo -e "${IBGBLUE} COPYRIGHT JOKERVPN, POWERED BY CYBERTIZE. ${PLAIN}"
echo ""