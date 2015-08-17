Percona-Server-server-56:
  pkg:
    - installed

MySQL-python:
  pkg:
    - installed

/data/mysql:
  file.directory:
    - names:
      - /data/mysql/db
      - /data/mysql/binlog
      - /data/mysql/slowlog
    - makedirs: True
    - user: mysql
    - group: mysql
