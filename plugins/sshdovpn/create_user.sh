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
read -p "Masukkan kata laluan: " KATALALUAN
read -p "Tempoh masa aktif (Hari) : " TEMPOHAKTIF

ALAMATIP=$( wget -qO- icanhazip.com );
ALAMATHOS=$( cat /etc/hostname );
TANGGALHARIINI=$( date +%s )
MASAAKTIFSAAT=$(( $TEMPOHAKTIF * 86400 ))
MASATAMATTEMPOH=$(( $TANGGALHARIINI + $MASAAKTIFSAAT ))
TARIKHLUPUT=$( date -u --date="1970-01-01 $MASATAMATTEMPOH sec GMT" +%F )
egrep "^$NAMAPENGGUNA" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
  echo -e "${RED}Nama pengguna tidak sah!${PLAIN}";
  exit 2
fi
useradd $NAMAPENGGUNA
usermod -s /bin/false $NAMAPENGGUNA
usermod -e $TARIKHLUPUT $NAMAPENGGUNA
echo -e "$KATALALUAN\n$KATALALUAN" | passwd $NAMAPENGGUNA &>/dev/null

echo -e "${IBGBLUE}         [ SSHD & OVPN ] ADD USER         ${PLAIN}"
echo -e "Alamat ip:     ${GREEN}$ALAMATIP${PLAIN}"
echo -e "Alamat hos:    ${GREEN}$ALAMATHOS${PLAIN}"
echo -e "Dropbear port: ${GREEN}442(TCP) 143(TLS)${PLAIN}"
echo -e "Squid port:    ${GREEN}8080 & 8000${PLAIN}"
echo -e "Openvpn TCP:   ${GREEN}http://$ALAMATHOS/client-tcp.ovpn${PLAIN}"
echo -e "Openvpn UDP:   ${GREEN}http://$ALAMATHOS/client-udp.ovpn${PLAIN}"
echo -e "Openvpn UDP:   ${GREEN}http://$ALAMATHOS/client-tls.ovpn${PLAIN}"
echo ""
echo -e "Nama pengguna: ${GREEN}$NAMAPENGGUNA${PLAIN}"
echo -e "Kata laluan:   ${GREEN}$KATALALUAN${PLAIN}"
echo -e "Tempoh aktif:  ${GREEN}$TEMPOHAKTIF hari${PLAIN}"
echo -e "Tarikh luput:  ${GREEN}$TARIKHLUPUT${PLAIN}"
echo -e "${IBGBLUE} COPYRIGHT JOKERVPN, POWERED BY CYBERTIZE. ${PLAIN}"
echo ""
