{% from 'zabbix/map.jinja' import zabbix with context %}

include:
  - zabbix.install_agent


{{ zabbix.config_agent }}:
  file.managed:
    - source: salt://file/zabbix/etc/zabbix_agentd.conf.jinja
    - template: jinja
    - require:
      - pkg: zabbix_agent
    - watch:
      - service: zabbix_agent


/etc/zabbix/bin:
  file.recurse:
    - source: salt://file/zabbix/discovery
    - user: zabbix
    - gourp: zabbixsrv
    - file_mode: 755
    - dir_mode: 755
    - clean: True
    - include_empty: True
    - makedirs: True
    - backup: minion
    - recurse:
      - user
      - group
      - mode
    - watch:
      - service: zabbix_agent
