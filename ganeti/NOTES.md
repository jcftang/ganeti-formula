Make sure cluster and node names are all valid DNS entries or else make sure they are in /etc/hosts

See short notes from

    http://wiki.adyxax.org/Miscellaneous/Ganeti
    http://docs.ganeti.org/ganeti/2.12/html/install.html#configuring-the-network

Creating a cluster...

    gnt-cluster init --vg-name=vg2 --enabled-hypervisors=kvm --master-netdev=br0 --hypervisor-parameters kvm:kernel_path='',vnc_bind_address=0.0.0.0 -N link=br0 root-cluster

-N link=br0 will put the VM's on that bridge

Add new instance

    gnt-instance add --os-type=debootstrap+default --disk-template=plain --os-size=10G --net=0:mac=54:52:00:02:00:9A,mode=bridged,link=br0 --backend-parameters=memory=1G,vcpus=1 root-vm1

PXE Boot an instance

    gnt-instance start --hypervisor-parameters boot_order=network root-vm-1.corp

Rebooting

    gnt-instance reboot --type=hard --shutdown-timeout=0 root-vm-1

Shutdown

    gnt-instance shutdown --timeout=0 root-vm-1
