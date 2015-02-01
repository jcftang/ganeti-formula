## the following assumes fixed ethernet ports on a server/desktop
eth0:
  network.managed:
    - enabled: True
    - type: eth
    - bridge: br0
    - proto: manual

br0:
  network.managed:
    - enabled: True
    - type: bridge
    - bridge: br0
    - proto: dhcp
    - ports: eth0
    - use:
      - network: eth0
    - require:
      - network: eth0
