{% from 'mariadb/map.jinja' import mysql with context %}

{{ mysql.mariadb_repo }}:
{% if salt['grains.get']('os_family') == 'RedHat' %}
  file.managed:
    - source: salt://file/yum/mariadb.repo
{% else %}
  pkgrepo:
    - managed
    - name: add-apt-repository 'deb http://ftp.osuosl.org/pub/mariadb/repo/10.0/ubuntu trusty main'
    - require:
      - cmd: {{ mysql.mariadb_repo }}
    cmd:
      - run
      - name: /usr/bin/apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
      - unless: /usr/bin/apt-key adv --list-key 0xcbcb082a1bb943db
{% endif %}
