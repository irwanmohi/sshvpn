#!/bin/bash
clear
set -euo pipefail

RED="\e[31m";
GREEN="\e[32m";
IBGGREEN="\e[1;102m";
PLAIN="\e[0m";

if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Skrip perlu dijalankan sebagai root!${PLAIN}"; exit 1
fi

if [[ ! -f /usr/share/plugins/cloudflare.conf ]]; then
  touch /usr/share/plugins/cloudflare.conf
fi

if [[ -z /usr/share/plugins/cloudflare.conf ]]; then
  read -p " Sila masukkan email cloudflare anda: " ID
  read -p " Sila masukkan API key cloudflare anda: " KEY

  echo "id=${ID}" > /usr/share/plugins/cloudflare.conf
  echo "key=${KEY}" >> /usr/share/plugins/cloudflare.conf
fi

if [[ ! -f /usr/share/plugins/domain ]]; then
  touch /usr/share/plugins/domain
fi
read -p "Sila masukkan domain anda: " DOMAIN
read -p "Sila masukkan subdomain anda: " SUB

CFID=$( grep 'id' /usr/share/plugins/cloudflare.conf | cut -d "=" -f 2 );
CFKEY=$( grep 'key' /usr/share/plugins/cloudflare.conf | cut -d "=" -f 2 );
GETIP=$( wget -qO- icanhazip.com );
SUBDOMAIN="${SUB}.${DOMAIN}";
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
    -H "X-Auth-Email: ${CFID}" \
    -H "X-Auth-Key: ${CFKEY}" \
    -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUBDOMAIN}" \
    -H "X-Auth-Email: ${CFID}" \
    -H "X-Auth-Key: ${CFKEY}" \
    -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
    RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
    -H "X-Auth-Email: ${CFID}" \
    -H "X-Auth-Key: ${CFKEY}" \
    -H "Content-Type: application/json" \
    --data '{"type":"A","name":"'${SUBDOMAIN}'","content":"'${GETIP}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
    -H "X-Auth-Email: ${CFID}" \
    -H "X-Auth-Key: ${CFKEY}" \
    -H "Content-Type: application/json" \
    --data '{"type":"A","name":"'${SUBDOMAIN}'","content":"'${GETIP}'","ttl":120,"proxied":false}')

echo "domain=${DOMAIN}" >> /usr/share/plugins/domain
echo "subdomain=${SUB}.${DOMAIN}" >> /usr/share/plugins/domain
echo -e "${IBGBLUE}             [ SERVER ] DOMAIN             ${PLAIN}"
echo -e "Domain baru anda adalah: ${GREEN}$DOMAIN${PLAIN}"
echo -e "Subdomain baru anda adalah: ${GREEN}$SUBDOMAIN${PLAIN}"
echo -e "${IBGBLUE} COPYRIGHT JOKERVPN, POWERED BY CYBERTIZE. ${PLAIN}"