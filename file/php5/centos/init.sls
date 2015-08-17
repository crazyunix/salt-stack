php5_reload:
  cmd.wait:
    - name: service php5-fpm reload
/etc/php5/:
  file.recurse:
    - source: salt://php5/conf/fpm
    - user: root
    - group: root
    - file_mode: 644
    - dir_mode: 755
    - makedirs: True
    - backup: minion
    - recurse:
      - user
      - group
      - mode
    - watch_in:
      - cmd: php5_reload
