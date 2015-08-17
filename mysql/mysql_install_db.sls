include:
  - mysql.install
  - mysql.config

mysql_install_db:
  cmd.run:
    - name:
      - /usr/bin/mysql_install_db --user=mysql --defaults-file=/etc/my.cnf
    - require:
      - file: /etc/my.cnf
