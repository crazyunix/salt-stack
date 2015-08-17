zabbix-agent:
  files_switch:
    - id
    - os_family
  server: localhost
  listenport: 10050
  listenip: 0.0.0.0
  serveractive: localhost
  logfile: /var/log/zabbix/zabbix_agentd.log
  include: /etc/zabbix/zabbix_agentd.d/
  userparameters:
    - net.ping[*],/usr/bin/fping -q -c3 $1 2>&1 | sed 's,.*/\[0-9.]*\)/.*,\1,'
    - custom.vfs.dev.discovery,/usr/local/bin/dev-discovery.sh
  extra_conf: |

  zabbix-server:
    files_switch:
      - id
      - os_family
    dbhost: localhost
    dbname: zabbix
    dbuser: zabbixuser
    dbpass: zabbixpass

  zabbix-mysql:
    file_switch:
      - id
      - os_family
    dbhost: localhost
    dbname: zabbix
    dbuser: zabbixuser
    dbpass: zabbixpass
    dbuser_host: '%'
    
  zabbix-frontend:
    files_switch:
      - id
      - os_family
    dbhost: localhost
    dbname: zabbix
    dbuser: zabbixuser
    dbpass: zabixpass
    zbxserver: localhost
    zbxserverport: 10051
    zbxservername: 'Zabbix installed with saltstack'


