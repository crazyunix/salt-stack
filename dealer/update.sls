{% from 'dealer/map.jinja' import nvm with context %}

/home/www-data/dealer.sh:
  file.managed:
    - source: salt://file/scripts/dealer.sh
    - unless: test -f /home/www-data/dealer.sh
    - user: www-data
    - group: www-data
    - mode: 755
dealer_file:
  file.recurse:
    - name: /data/website/dealer
    - source: salt://storage/dealer
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

update_dealer:
  cmd.run:
    - cwd: /data/website/dealer
    - user: www-data
    - names:
      - ~/dealer.sh
      #- npm install 
      #- bower install && gulp build'
    - require:
      - file: dealer_file
