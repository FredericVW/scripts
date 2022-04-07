clear
echo "Zorg dat je twee adapters hebt. De eerste op DHCP en in VMware als NAT."
echo "De tweede zet je op een nieuw LAN segment in VMware."
echo "Zet in Linux je vaste adapter op het juiste IP, zonder gateway."
echo "Je zal in de file onder /etc/netplan/... wellicht een adapter moeten toevoegen."
echo "Dit zijn jouw adapters:"
ls /sys/class/net | grep -v lo
echo "------"
read -p "Verwijder in de file die komt hekje bij net.ipv4.ip_forward=1 " VAR
nano /etc/sysctl.conf 
sysctl -p
echo "------"
read -p "Bevestig hierna twee maal met Yes." VAR
apt install iptables-persistent
iptables -t nat -A POSTROUTING -j MASQUERADE
iptables -t nat -I PREROUTING -p tcp -i ens33 --dport 220 -j DNAT --to-destination 192.168.15.20:22
ip a
iptables -t nat -I PREROUTING -p tcp -i ens33 --dport 229 -j DNAT --to-destination 192.168.15.129:22
iptables-save > /etc/iptables/rules.v4
