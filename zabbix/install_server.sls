{% from 'zabbix/map.jinja' import zabbix with context %}

#zabbix-server:
#  pkg:
#    - name: {{ zabbix.pkg_server }}
#    - installed
#  service:
#    - name: {{ zabbix.service_server }}
#    - running
#    - enable: True
#    - require: 
#      - pkg: zabbix-server
#
{{ zabbix.config_server }}: 
  file.managed:
    - source: salt://file/zabbix/etc/zabbix_server.conf.jinja
    - template: jinja
    #    - require:
      #  - pkg: zabbix-server
