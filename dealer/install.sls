{% from 'dealer/map.jinja' import nvm with context %}
include:
  - user.init

unzip:
  pkg: 
    - name: unzip
    - installed

nvm-tar:
  file.managed:
    - name: /home/www-data/master.zip
    - unless:
      - test -d /home/www-data/.nvm
    - source: salt://piston/master.zip
    - user: www-data
    - group: www-data
    - require:
      - pkg: unzip
      - user: www-data

nvm-unpack:
  cmd.run:
    - cwd: /home/www-data/
    - user: www-data
    - names:
      - /usr/bin/unzip master.zip
      - '/bin/mv nvm-master .nvm'
      - 'echo "source ~/.nvm/nvm.sh" >> ~/.bash_profile'
    - unless: test -d /home/www-data/.nvm
    - watch:
      - file: nvm-tar

nvm-install:
  cmd.run:
    - cwd: /home/www-data/
    - user: www-data
    - names: 
      - "source $HOME/.nvm/nvm.sh && nvm install {{ nvm.version }}"
      - "source $HOME/.nvm/nvm.sh && nvm alias default {{ nvm.version }}"
      - "source $HOME/.nvm/nvm.sh && npm install -g grunt-cli"
    - require:
      - cmd: nvm-unpack
