{% if grains['os_family'] == 'RedHat' %}
httpd:
{% else %}
apache2:
{% endif %}
  pkg:
    - installed
    - &watching
        - watch_in:
          {% if grains['os_family'] == 'RedHat' %}
          - service: httpd
          {% else %}
          - service: apache2
          {% endif %}
    - <<: *watching
    - service:
      - running

/etc/apache2/apache2.conf:
  file:
    - managed
    - source: salt://httpd/httpd.conf
    - &userdata
        - user: root
        - group: root
    - <<: *userdata
    - mode: 644
    - <<: *watching

/etc/apache2/sites-enabled/000-default.conf:
  file:
    - managed
    - source: salt://httpd/000-default.conf
    - <<: *userdata
    - mode: 644
    - <<: *watching

/var/www/html:
  file.directory:
    - <<: *userdata
    - mode: 755

/var/www/html/index.html:
  file:
    - managed
    - source: salt://httpd/index.html
    - <<: *userdata
    - mode: 644
