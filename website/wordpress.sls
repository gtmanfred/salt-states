wordpress:
  archive:
    - extracted
    - name: /srv/
    - source: http://wordpress.org/wordpress-{{ pillar['wordpress']['wp-version'] }}.tar.gz
    - source_hash: md5=d0b0396e84942faf87ccde819df0916f
    - archive_format: tar
    - if_missing: /srv/wordpress/

curl:
  pkg.installed

{%- set addrs = salt['mine.get']('db*', 'network.ip_addrs') %}

{%- if addrs is defined %}
{% if salt['grains.has_value']('wp_salt') %}
  {% set wp_salt = grains['wp_salt'] %}
{% else %}
  {% set wp_salt = salt['cmd.run']("/usr/bin/wget -O - -q https://api.wordpress.org/secret-key/1.1/salt/") %}
{% endif %}

wp-salt:
  grains.present:
    - name: wp_salt
    - value: |
             {{ wp_salt|indent(13, false) }}

#{%- for name, addrlist in addrs.items() %}
/srv/wordpress/wp-config.php:
  file:
    - managed
    - user: www-data
    - group: www-data
    - mode: 644
    - source: salt://website/files/wp-config.php
    - template: jinja
    - context:
        wp_salt: |
                 {{ wp_salt|indent(17, false) }}
        addr: {{ addrs.items()[0][1][0] }}
        #addr: {{ addrlist[0] }}
    - require:
      - file: /srv/wordpress
#{% endfor %}
{% endif %}

/srv/wordpress:
  file.directory:
    - user: www-data
    - group: www-data
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True
    - recurse:
      - user
      - group
      - mode
