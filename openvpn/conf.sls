/etc/openvpn:
  file.recurse:
    - source: salt://file/openvpn
    - user: root
    - group: root
    - clean: True
    - recurse:
      - user
      - group
    - watch_in:
      - service: openvpn
