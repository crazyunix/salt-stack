
#dev:
#{% set name = salt['grains.get']('role','') %}
#{% if name %}
#  'role:{{ name[0] }}':
#    - match: grain
#    - user
#    - nginx
#{% endif %}
#
##最简单的实现方式 使用Grains 模式
#dev:
#  'role:web':
#    - match: grain
#    - user
#    - nginx
#
base:
  gdweb:
    - match: nodegroup
    - nginx
  laravel:
    - match: nodegroup
    - web
  piston:
    - match: nodegroup
    - piston
  dealer:
    - match: nodegroup
    - dealer
