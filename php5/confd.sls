{% from 'php5/map.jinja' import php with context %}
include:
  - php5.install
php5_reload:
  cmd.wait:
    - name: service php-fpm reload

{{ php.fpm_confd }}:
  file.recurse:
    - source: {{ php.confd_source_salt }}
    - user: root
    - group: root
    - file_mode: 644
    - dir_mode: 755
    - makedirs: True
    - clean: True
    - backup: minion
    - recurse:
      - user
      - group
      - mode
    - watch_in:
      - cmd: php5_reload
