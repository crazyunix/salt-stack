include:
  - web.update
migrate:
  cmd.run:
    - cwd: /data/website/laravel
    - name: /usr/bin/php artisan migrate 
    - require:
      - file: /data/website/laravel
