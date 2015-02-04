# See https://people.debian.org/~ultrotter/talks/dc9/dc9_ganeti_talk.html - it's a nice way of setting up a dev system in terms of networking.
# cat >>/etc/network/interfaces <<EOF
# iface dummy0 inet static
# address 10.0.4.254
# netmask 255.255.255.0
#
# iface br0 inet static
# address 10.0.4.254
# netmask 255.255.255.0
# bridge_ports dummy0
# pre-up /sbin/ifup dummy0
# up /etc/init.d/dnsmasq restart
# down /etc/init.d/dnsmasq stop
# EOF

$IPT -N FWD_VIRTUAL
$IPT -t nat -N PST_VIRTUAL

$IPT -A FORWARD -m state --state INVALID -j DROP
$IPT -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
$IPT -A FORWARD -j FWD_VIRTUAL

$IPT -t nat -A POSTROUTING -j PST_VIRTUAL

$IPT -F FWD_VIRTUAL
$IPT -A FWD_VIRTUAL -s 10.0.4.0/24 -i br0 -j ACCEPT
$IPT -A FWD_VIRTUAL -s 10.0.4.0/24 -i tap+ -j ACCEPT

$IPT -t nat -F PST_VIRTUAL
$IPT -t nat -A PST_VIRTUAL -s 10.0.4.0/24 -o wlan0 -j MASQUERADE
$IPT -t nat -A PST_VIRTUAL -s 10.0.4.0/24 -o wlan1 -j MASQUERADE
$IPT -t nat -A PST_VIRTUAL -s 10.0.4.0/24 -o eth0 -j MASQUERADE
$IPT -t nat -A PST_VIRTUAL -s 10.0.4.0/24 -o eth2 -j MASQUERADE
$IPT -t nat -A PST_VIRTUAL -s 10.0.4.0/24 -o ppp0 -j MASQUERADE
