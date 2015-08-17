## create www-data
include:
  - user.init
  - zabbix.install_agent

##CentOS yum remi repo
yum:
  file.managed:
    - name: /etc/yum.repos.d/CentOS.repo
    - source: salt://file/nginx/CentOS.repo
    - unless: test -f /etc/yum.repos.d/CentOS.repo
nginx:
  pkg:
    - name: nginx
    - installed
  service.running:
      - enable: True
      - reload: True
      - watch:
        - file: /etc/nginx/nginx.conf
        - pkg: nginx
  file.managed:
    - name: /etc/nginx/nginx.conf
    - source: salt://file/nginx/nginx.conf
    - user: root
    - require:
      - pkg: nginx
      - user: www-data

nginx_reload:
  cmd.wait:
    - name: service nginx  reload

roles:
  file.managed:
    - name: /etc/salt/minion.d/roles.conf
    - source: salt://file/role/roles.conf.jinja
    - template: jinja
    - require:
      - pkg: nginx
    - watch:
      - service: zabbix_agent


#web-server-role:
#  file.append: 
#    - name: /etc/salt/roles
#    - text:
#      - 'web-server'
#    - require:
#      - file: roles
