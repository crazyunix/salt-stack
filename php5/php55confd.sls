{% from 'php5/map.jinja' import php with context %}
{% from 'php5/php55map.jinja' import php55 with context %}
include:
  - php5.install
php5_reload:
  cmd.wait:
    - name: service php55-php-fpm reload

{{ php.fpm_confd }}:
  file.symlink:
    - target: {{ php55.fpm_confd }}
    - unless: test -l {{ php.fpm_confd }}
    - require:
      - pkg: {{ php.fpm_pkg }}
{{ php.php_ini }}:
  file.symlink:
    - target: {{ php55.php_ini }}
    - unless: test -l {{ php.php_ini }}
    - require:
      - pkg: {{ php.php_pkg }}
{{ php.fpm_conf }}:
  file.symlink:
    - target: {{ php55.fpm_conf }}
    - unless: test -l {{ php.fpm_conf }}

{{ php55.php_phpd }}:
  file.symlink:
    - target: {{ php55.php55d }}
    - unless: test -l {{ php55.php_phpd }}

{{ php55.fpm_confd }}:
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
{{ php55.php_phpd }}/z-memcached.ini:
  file.replace:
    - pattern: 'memcached.compression_threshold = 2000'
    - repl: 'memcached.compression_threshold = 52400'
    - watch_in:
      - cmd: php5_reload
