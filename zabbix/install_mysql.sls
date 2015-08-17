{% from 'zabbix/map.jinja' import zabbix with context %}
###setup zabbix database
{% set dbhost = salt['pillar.get']('zabbix-mysql:dbhost', 'localhost') %}
{% set dbname = salt['pillar.get']('zabbix-mysql:dbname', 'zabbix') %}
{% set dbuser = salt['pillar.get']('zabbix-mysql:dbuser', 'zabbixuser') %}
{% set dbpass = salt['pillar.get']('zabbix-mysql:dbpass', 'zabbixpass') %}
{% set dbuser_host = salt['pillar.get']('zabbix-mysql:dbuser_host', 'localhost') %}

include:
  - mariadb.install
zabbix_db:
  mysql_database.present:
    - name: {{ dbname }}
    - character_set: utf8
    - collate: utf8_bin
  mysql_grants:
    - present
    - grant: all privileges
    - database: {{ dbname }}.*
    - user: {{ dbuser }}
    - host: {{ dbuser_host }}
    - require:
      - mysql_database: zabbix_db
  mysql_user:
    - present
    - name: {{ dbuser }}
    - host: '{{ dbuser_host }}'
    - password: {{ dbpass }}
    - require:
      - mysql_grants: zabbix_db

{% if salt['grains.get']('os_family') == 'RedHat' %}
  {% for file in ['/usr/share/zabbix-mysql/schema.sql',
    '/usr/share/zabbix-mysql/images.sql',
    '/usr/share/zabbix-mysql/data.sql',] %}
{{ file }}:
  #file:
  #  - managed
  #  - source:
  #    - salt://file/zabbix/etc/db/{{ file }}
  cmd:
    - run 
    - name: /usr/bin/mysql -h {{ dbhost }} -u {{ dbuser }} --password={{ dbpass }} {{ dbname }} < {{ file }} && touch {{ file }}.applied
    - unless: test -f {{ file }}.applied
  {% endfor %}


{% else %}  
  {% for file in ['/usr/share/zabbix-server-mysql/schema.sql',
    '/usr/share/zabbix-server-mysql/images.sql',
    '/usr/share/zabbix-server-mysql/data.sql',] %}
{{ file }}:
  #file:
  #  - managed
  #  - source:
  #    - salt://file/zabbix/etc/db/{{ file }}
  cmd:
    - run 
    - name: /usr/bin/mysql -h {{ dbhost }} -u {{ dbuser }} --password={{ dbpass }} {{ dbname }} < {{ file }} && touch {{ file }}.applied
    - unless: test -f {{ file }}.applied
  {% endfor %}
{% endif %}
