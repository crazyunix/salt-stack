include:
  - mysql.install

/etc/my.cnf:
  file.managed:
    - source: salt://file/mysql/my.cnf
    - user: root

mysql:
  service.running:
    - enable: True
    - watch:
      - file: /etc/my.cnf
    - require:
      - pkg: Percona-Server-server-56
    
