#!/bin/bash
clear

RED="\e[0;31m"
GREEN="\e[0;32m"
IBGBLUE="\e[1;104m"
PLAIN="\e[0m"

if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Skrip perlu dijalankan sebagai root!${PLAIN}"; exit 1
fi

ALAMATIP=$( wget -qO- icanhazip.com );
ALAMATHOS=$( cat /etc/hostname );
NAMAPENGGUNA=$(</dev/urandom tr -dc A-Z | head -c5);
KATALALUAN=$(</dev/urandom tr -dc 0-9 | head -c5);
TEMPOHAKTIF=1;

TARIKHLUPUT=$(date -d "$TEMPOHAKTIF days" +"%Y-%m-%d");
useradd -e `date -d "$TEMPOHAKTIF days" +"%Y-%m-%d"` -s /bin/false -M $NAMAPENGGUNA
echo -e "$KATALALUAN\n$KATALALUAN" | passwd $NAMAPENGGUNA &>/dev/null

echo -e "${IBGBLUE}        [ SSHD & OVPN ] TRIAL USER        ${PLAIN}"
echo -e "Alamat ip:     ${GREEN}$ALAMATIP${PLAIN}"
echo -e "Alamat hos:    ${GREEN}$ALAMATHOS${PLAIN}"
echo -e "Dropbear port: ${GREEN}1372(HTTP) 2021(TLS)${PLAIN}"
echo -e "Squid port:    ${GREEN}8080 & 8000${PLAIN}"
echo -e "Openvpn TCP:   ${GREEN}http://$ALAMATHOS/client-tcp.ovpn${PLAIN}"
echo -e "Openvpn UDP:   ${GREEN}http://$ALAMATHOS/client-udp.ovpn${PLAIN}"
echo ""
echo -e "Nama pengguna: ${GREEN}$NAMAPENGGUNA${PLAIN}"
echo -e "Kata laluan:   ${GREEN}$KATALALUAN${PLAIN}"
echo -e "Tempoh aktif:  ${GREEN}$TEMPOHAKTIF hari${PLAIN}"
echo -e "Tarikh luput:  ${GREEN}$TARIKHLUPUT${PLAIN}"
echo -e "${IBGBLUE} COPYRIGHT JOKERVPN, POWERED BY CYBERTIZE. ${PLAIN}"
echo ""
