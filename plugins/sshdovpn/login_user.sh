#!/bin/bash
clear

RED="\e[0;31m"
GREEN="\e[0;32m"
IBGBLUE="\e[1;104m"
PLAIN="\e[0m"

if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Skrip perlu dijalankan sebagai root!${PLAIN}"; exit 1
fi

SSHDPID=( `ps aux | grep -i dropbear | awk '{print $2}'` );
cat "/var/log/auth.log" | grep -i dropbear | grep -i "Password auth succeeded" > /tmp/sshd_login.log;
echo -e "${IBGBLUE}           [ SSHD ] USERS LOGIN           ${PLAIN}"
echo -e "${GREEN}Proses ID - Nama pengguna - Alamat IP${PLAIN}"

for PID in "${SSHDPID[@]}"
do
	cat /tmp/sshd_login.log | grep "dropbear\[$DBPID\]" > /tmp/sshd_login_pid.log;
	JUMLAHPENGGUNA=$(cat /tmp/sshd_login_pid.log | wc -l)
	NAMAPENGGUNA=$(cat /tmp/sshd_login_pid.log | awk '{print $10}')
	ALAMATIP=$(cat /tmp/sshd_login_pid.log | awk '{print $12}')
	if [ $JUMLAHPENGGUNA -eq 1 ]; then
		echo "$DBPID - $NAMAPENGGUNA - $ALAMATIP";
	fi
done

echo "";
if [ -f "/var/log/openvpn/status.log" ]; then
	line=`cat /var/log/openvpn/status.log | wc -l`
	a=$((3 + ((line - 8) / 2)));
	b=$((( line - 8 ) / 2));
	echo -e "${IBGBLUE}           [ OVPN ] USERS LOGIN           ${PLAIN}"
	echo -e "${GREEN}Nama pengguna - Alamat IP - Log masuk${PLAIN}"

	cat /var/log/openvpn/status.log | head -n $a | tail -n $b | cut -d "," -f 1,2,5 | sed -e 's/,/   /g' > /tmp/vpn-login-db.txt
	cat /tmp/vpn-login-db.txt

	echo -e "${IBGBLUE} COPYRIGHT JOKERVPN, POWERED BY CYBERTIZE. ${PLAIN}"
	echo "";
fi
