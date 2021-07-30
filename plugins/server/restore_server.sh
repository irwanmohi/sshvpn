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
cp -r backup/shadowsocks-libev /etc/
cp -r backup/v2ray /etc/
cp -r wireguard /etc/

# sslibev
SENARAI=( `cat /etc/shadowsocks-libev/accounts | cut -d ' ' -f 1` );
TODAY=$( date +%F );
for PENGGUNA in "${SENARAI[@]}"; do
  USEREXP=$( grep -w "^$PENGGUNA" /etc/shadowsocks-libev/accounts | cut -d ' ' -f 9 );
  EXPSEC=$(date -d "$USEREXP" +%s);
  TODAYSEC=$(date -d "$TODAY" +%s);
  EXPIRED=$(( ($EXPSEC - $TODAYSEC) / 86400 ));
  printf "$USER\n$EXPIRED\n" | bash /usr/share/plugins/libev/create.sh
done

# v2ray
SENARAI=( `cat /etc/v2ray/accounts | cut -d ' ' -f 1` );
TODAY=$( date +%F );
for PENGGUNA in "${SENARAI[@]}"; do
  USEREXP=$( grep -w "^$PENGGUNA" /etc/v2ray/accounts | cut -d ' ' -f 9 );
  EXPSEC=$(date -d "$USEREXP" +%s);
  TODAYSEC=$(date -d "$TODAY" +%s);
  EXPIRED=$(( ($EXPSEC - $TODAYSEC) / 86400 ));
  printf "$USER\n$EXPIRED\n" | bash /usr/share/plugins/v2ray/create_client.sh
done

# wireguard
data=( `cat /etc/wireguard/wg0.conf | grep '^### Client' | cut -d ' ' -f 3` );
for user in "${data[@]}"; do
  chmod 777 /var/www/html/$user.conf
done

rm -rf /root/backup && rm -f backup.zip
echo -e "${IBGBLUE} COPYRIGHT JOKERVPN, POWERED BY CYBERTIZE. ${PLAIN}"