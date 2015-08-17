www-data:
  user.present:
    - fullname: www-data
    - shell: /bin/bash
    - home: /home/www-data
    - uid: 1001
    - gid: 1001
    - groups:
      - www-data
    - require:
      - group: www-data
  group.present:
    - gid: 1001
    - name: www-data

