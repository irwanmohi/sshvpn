#!/bin/bash
clear

RED="\e[0;31m"
GREEN="\e[0;32m"
IBGBLUE="\e[1;104m"
PLAIN="\e[0m"

if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Skrip perlu dijalankan sebagai root!${PLAIN}"; exit 1
fi

echo -e "${IBGBLUE}        [ SSHD & OVPN ] USERS LIST        ${PLAIN}"
echo -e "${GREEN}Nama pengguna - Tarikh luput${PLAIN}"
echo "--------------------------------------"
while read EXPIRED
do
  NAMAPENGGUNA="$(echo $EXPIRED | cut -d: -f1)"
  IDPENGGUNA="$(echo $EXPIRED | grep -v nobody | cut -d: -f3)"
  TARIKHLUPUT="$(chage -l $NAMAPENGGUNA | grep "Account expires" | awk -F": " '{print $2}')"
  if [[ $IDPENGGUNA -ge 1000 ]]; then
    printf "%-15s %2s\n" "$NAMAPENGGUNA" "$TARIKHLUPUT"
  fi
done < /etc/passwd
JUMLAH="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
echo "--------------------------------------"
echo -e "${GREEN}Jumlah: $JUMLAH pengguna${PLAIN}"
echo -e "${IBGBLUE} COPYRIGHT JOKERVPN, POWERED BY CYBERTIZE. ${PLAIN}"
echo ""