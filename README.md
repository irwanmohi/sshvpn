# Virtual Private Server [ JokerVPN ]

## HOWTO

Before you download or after downloading the script, you need to edit your server hostname first,
by entering this command on your terminal:
``` bash
nano /etc/hostname
```
or the easyway to change hostname by run this command:
``` bash
echo 'jokervpn.com' | tee /etc/hostname
echo 'jokervpn.com' > /etc/hostname
```

to check hostname enter this command on your terminal:
``` bash
cat /etc/hostname
```

the script will read hostname as your default host/domain, so you need to edit and set hostname on your server. If you done with that, you can run the script by entering this command:
``` bash
chmod +x install && ./install
```

the easyway to run bash script by doing it this way, by entering this command:
```bash
bash install
```

**The script will take sometime to complete, please wait for it...**

## INFO

_What the script will do?_
1. update & upgrade
2. install dependencies
3. install packages

### Packages list:
- dropbear
- openvpn
- squid
- stunnel
- badvpn-udpgw
- nginx
- webmin
- fail2ban
- ddos-deflate
- iptables
- plugins


### Plugins | Menu
*plugins is a* __menu__ *to make it easier for:*

No.|Name|Details
:--- |---- |---- 
01|trial_user|Jana akaun percubaan untuk sehari
02|create|Buat akaun pengguna untuk sshd & ovpn
03|renew|Tambah tempoh masa aktif akaun pengguna
04|login|Senaraikan pengguna yang log masuk
05|lists|Senaraikan semua akaun pengguna
06|limit|Senaraikan akaun log masuk berganda
07|kick|Tendang pengguna multilogin
08|kill|Hentikan pengguna multilogin
09|unlock|Buka kunci atau dayakan akaun pengguna
10|lock|Kunci atau nyahdayakan akaun pengguna
11|delete|Padamkan akaun pengguna
12|check|Semak perkhidmatan
13|feature|Perincian perkhidmatan
14|ports|Tukar port perkhidmatan
15|restart|Mulakan semula perkhidmatan
16|domain|Tambah domain or/and subdomain
17|backup|Data sandaran
18|restore|Pulihkan data
19|speed|Uji kelajuan pelayan
20|detail|Perincian pelayan
21|reboot|Mulakan semula pelayan
