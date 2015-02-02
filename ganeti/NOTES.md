Make sure cluster and node names are all valid DNS entries or else make sure they are in /etc/hosts

See short notes from

    http://wiki.adyxax.org/Miscellaneous/Ganeti
    http://docs.ganeti.org/ganeti/2.12/html/install.html#configuring-the-network
    https://nsrc.org/workshops/2014/sanog23-virtualization/raw-attachment/wiki/Agenda/ex-ganeti-install.htm

Creating a cluster...

    gnt-cluster init --vg-name=vg2 --enabled-hypervisors=kvm --master-netdev=br0 --hypervisor-parameters kvm:kernel_path='',vnc_bind_address=0.0.0.0 -N link=br0 root-cluster

-N link=br0 will put the VM's on that bridge

Add new instance

    gnt-instance add --os-type=debootstrap+default --disk-template=plain --os-size=10G --net=0:mac=54:52:00:02:00:9A,mode=bridged,link=br0 --backend-parameters=memory=1G,vcpus=1 root-vm1

PXE Boot an instance

    gnt-instance start --hypervisor-parameters boot_order=network root-vm-1

Rebooting

    gnt-instance reboot --type=hard --shutdown-timeout=0 root-vm-1

Shutdown

    gnt-instance shutdown --timeout=0 root-vm-1

Getting thie ganeti-os-noop package makes it easier to create instances with no OS install, this means something like cobbler/foreman can be used instead to kick off fresh installs of VM's

See

    https://github.com/grnet/ganeti-os-noop

Installing from a CD?

    gnt-instance add -t plain -o noop -s 3GB -B memory=128M --no-install --no-start --no-ip-check --no-name-check -H kvm:vnc_bind_address=0.0.0.0,boot_order=cdrom,cdrom_image_path=/root/linux.iso root-vm3

Locking the vnc console

    echo 'xyzzy' >/etc/ganeti/vnc-cluster-password
    gnt-cluster modify -H kvm:vnc_password_file=/etc/ganeti/vnc-cluster-password
