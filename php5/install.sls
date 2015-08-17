{% from "php5/map.jinja" import php with context %}
{% from "php5/php55map.jinja" import php55 with context %}
{% if grains['os_family'] == 'Debian' %}
{% set use_ppa  = salt['pillar.get']('php:use_ppa', none) %}
{% if use_ppa is not none %}
{% set use_ppa = salt['pillar.get']('php:ppa_name','ondrej/php5') %}
##ubuntu ppa 
php54:
  pkgrepo.managed:
    - ppa: {{ppa_name}}
  pkg.latest:
    - name: php5
    - refresh: True
    {% endif %}
  {% else %}
##CentOS yum remi repo
php54:
  cmd.run:
    #    - name: "rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm" 
    - name: "rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm"
    - unless: test -f /etc/yum.repos.d/remi.repo
repo:
  file.replace:
    - name: /etc/yum.repos.d/remi.repo
    - pattern: 'enabled=0'
    - repl: 'enabled=1'
    - count: 0
{% endif %}

php5:
  pkg.installed:
    - name: {{ php.php_pkg }}

#php-mysql:
#  pkg.installed:
#    - name: {{ php.mysql_pkg}}
#

php-mysqlnd:
  pkg.installed:
    - name: {{ php.mysqlnd_pkg }}

php-pear:
  pkg.installed:
    - name: {{ php.pear_pkg }}

php-soap:
  pkg.installed:
    - name: {{ php.soap_pkg }}

php-sqlite:
  pkg.installed:
    - name: {{ php.sqlite_pkg }}

php-imagick:
  pkg.installed:
    - name: {{ php.imagick_pkg }}

php-xml:
  pkg.installed:
    - name: {{ php.xml_pkg }}

php-ldap:
  pkg.installed:
    - name: {{ php.ldap_pkg }}
php-memcache:
  pkg.installed:
    - name: {{ php.memcache_pkg }}

php-memcached:
  pkg.installed:
    - name: {{ php.memcached_pkg }}
php-mbstring:
  pkg.installed:
    - name: {{ php.mbstring_pkg }}

php-curl:
  pkg.installed:
    - name: {{ php.curl_pkg }}

php-gd:
  pkg.installed:
    - name: {{ php.gd_pkg }}
php-json:
  pkg.installed:
    - name: {{ php.json_pkg }}

php-mcrypt:
  pkg.installed:
    - name: {{ php.mcrypt_pkg }}
php-opcache:
  pkg.installed:
    - name: {{ php.opcache_pkg }}
php-fpm:
  pkg.installed:
    - name: {{ php.fpm_pkg }}
  service.running:
    - name: {{ php55.fpm_service }}
    - enable: True
    - reload: True
    #    - watch:
      # - file: {{ php.fpm_conf }}
      #  file.managed:
      #    - name: {{ php.fpm_conf }}
      #    - source: {{ php.source_salt }}
      #    - user: root
      #    - require:
      #      - pkg: php-fpm
      #
{% if grains['os_family'] == 'RedHat' %}
/usr/bin/php:
  file.symlink:
    - target: /usr/bin/php55
    - require:
      - pkg: php5
{% endif %}
