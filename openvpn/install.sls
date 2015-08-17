openvpn:
  pkg:
    - name: openvpn
    - installed
  service.running:
    - enable: True
    - reload: True

