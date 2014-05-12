{%- set addrs = salt['mine.get']('redis*', 'network.ip_addrs') %}


php-pear:
  pkg.installed

php5-dev:
  pkg.installed

redis:
  pecl.installed:
    - require:
      - pkg: php-pear
      - pkg: php5-dev
      - pkg: build-essential

{%- if addrs is defined %}
{%- for name, addrlist in addrs.items() %}
/etc/php5/apache2/conf.d/15-redis.ini:
  file:
    - managed
    - user: root
    - group: root
    - mode: 644
    - source: salt://php/files/redis.ini
    - template: jinja
    - context:
      addr: {{ addrlist[0] }}

{% endfor %}

{% endif %}
