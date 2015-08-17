{% from 'zabbix/map.jinja' import zabbix with context %}

zabbix_agent:
  pkg:
    - installed
    - name: {{ zabbix.pkg_agent }}
  service:
    - running
    - name: {{ zabbix.service_agent }}
    - reload: True
    - enable: True
    - require:
      - pkg: zabbix_agent
