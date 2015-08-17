{% from 'zabbix/map.jinja' import zabbix with context %}

zabbix-web:
  pkg:
    - installed
    - name: {{ zabbix.pkg_frontend }}

{% set files_switch = salt['pillar.get']('zabbix-frontend:files_switch',['id']) %}

{{ zabbix.config_frontend }}:
  file.managed:
    - source:
      - salt://file/zabbix/web/zabbix.conf.php.jinja
    - template: jinja
    - require:
      - pkg: zabbix-web

{{ zabbix.service_http }}:
  service.running:
    - entable: True
    - watch:
      - file: {{ zabbix.config_frontend }}
{{ zabbix.config_php }}:
    file.sed:
      - before: ''
      - after: 'date.timezone = Asia/Shanghai'
      - limit: ';date.timezone.*'
      - back:.bak
