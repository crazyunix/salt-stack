include:
  - nfs.install
  - user.adduser

/data/website/laravel/public/upload:
  mount.mounted:
    - device: 192.168.1.2:/data/laravel_upload
    - fstype: nfs
    - mkmnt: True
    - opts: defaults
    - user: www-data
    - group: www-data
    - require:
      - pkg: nfs-server
      - user: www-data
