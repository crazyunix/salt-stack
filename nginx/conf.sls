nginx_reload:
  cmd.wait:
    - name: service nginx  reload
/etc/nginx/conf.d:
  file.recurse:
    - source: salt://file/nginx/conf.d
    - user: root
    - group: root
    - file_mode: 644
    - dir_mode: 755
    - clean: True
    - include_empty: True
    - makedirs: True
    - backup: minion
    - recurse:
      - user
      - group
      - mode
    - watch_in:
      - cmd: nginx_reload
