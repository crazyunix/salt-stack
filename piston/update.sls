{% from 'piston/map.jinja' import nvm with context %}
#piston_git:
#  git.latest:
#    - name: git@git.hezuo.tk:frontend/piston.git
#    - rev: master
#    - target: /srv/salt/dev/storage/piston 

/home/www-data/piston.sh:
  file.managed:
    - source: salt://file/scripts/piston.sh
    - unless: test -f /home/www-data/piston.sh
    - user: www-data
    - group: www-data
    - mode: 755

piston_file:
  file.recurse:
    - name: /data/website/piston
    - source: salt://storage/piston
    - exclude_pat: "*.git*"
    - include_empty: True
    - user: www-data
    - group: www-data
    - file_mode: 0644
    - dir_mode: 755
    - makedirs: True
    - recurse:
      - user
      - group
      - file_mode

update_piston:
  cmd.run:
    - cwd: /data/website/piston
    - user: www-data
    - names:
      - ~/piston.sh
      #- npm install 
      #- bower install && gulp build'
    - watch:
      - file: piston_file
