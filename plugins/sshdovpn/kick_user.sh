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

if [[ ! -f /usr/local/bin/kick_user.sh ]]; then
  cp /usr/share/plugins/sshdovpn/kick_user.sh /usr/local/bin/kick_user.sh
  chmod +x /usr/local/bin/kick_user.sh
fi
if [[ ! -d /tmp/report ]]; then
  mkdir /tmp/report
fi

MAX=2
grep "/home/" /etc/passwd | cut -d: -f1 > /tmp/report/user.txt
USERLISTS=( `cat "/tmp/report/user.txt"` );
i=0;
for USER in "${USERLISTS[@]}"; do
  USERNAME[$i]=`echo $USER | sed 's/'\''//g'`;
  TOTAL[$i]=0;
  i=$i+1;
done

LOG="/var/log/auth.log";
cat $LOG | grep -i dropbear | grep -i "Password auth succeeded" > /tmp/log-db.txt
proc=( `ps aux | grep -i dropbear | awk '{print $2}'`);
for PID in "${proc[@]}"
do
  cat /tmp/log-db.txt | grep "dropbear\[$PID\]" > /tmp/log-db-pid.txt
  NUM=`cat /tmp/log-db-pid.txt | wc -l`;
  USER=`cat /tmp/log-db-pid.txt | awk '{print $10}' | sed 's/'\''//g'`;
  IP=`cat /tmp/log-db-pid.txt | awk '{print $12}'`;
  if [ $NUM -eq 1 ]; then
    i=0;
    for user1 in "${USERNAME[@]}"
    do
      if [ "$USER" == "$user1" ]; then
        TOTAL[$i]=`expr ${TOTAL[$i]} + 1`;
        pid[$i]="${pid[$i]} $PID"
      fi
      i=$i+1;
    done
  fi
done

j="0";
for i in ${!USERNAME[*]}
do
  if [ ${TOTAL[$i]} -gt $MAX ]; then
    date=`date +"%Y-%m-%d %X"`;
    echo "$date - ${USERNAME[$i]} - ${TOTAL[$i]}";
    echo "$date - ${USERNAME[$i]} - ${TOTAL[$i]}" >> /root/log-limit.txt;
    kill ${pid[$i]};
    pid[$i]="";
    j=`expr $j + 1`;
  fi
done

if [ $j -gt 0 ]; then
  systemctl restart ssh > &>/dev/null
  systemctl restart dropbear &>/dev/null
  j=0;
fi
