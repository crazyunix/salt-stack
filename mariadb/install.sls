{% from "mariadb/map.jinja" import mysql with context %}


mysql:
  pkg.installed:
    - name: {{ mysql.mysql_pkg }}
  service.running:
    - name: {{ mysql.service_server }}
    - enable: True
    - require:
      - pkg: mysql

mysql_client:
  pkg.installed:
    - name: {{ mysql.client_pkg }}

{% if salt['grains.get']('os_family') == 'Debian' %}
mysql_libmariadbclient:
  pkg.installed:
    - name: {{ mysql.libclient_pkg}}
{% endif %}
mysql_dev:
  pkg.installed:
    - name: {{ mysql.mysql_dev }}
    - require:
      - pkg: mysql

mysql_python:
  pkg.installed:
    - name: {{ mysql.pkg_python }}
    - require:
      - pkg: mysql_dev
