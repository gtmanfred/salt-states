{% if grains['os_family'] == 'RedHat' %}
httpd:
{% else %}
apache2:
{% endif %}
  pkg:
    - installed
    - watch_in:
      {% if grains['os_family'] == 'RedHat' %}
      - service: httpd
      {% else %}
      - service: apache2
      {% endif %}
    - service:
      - running

/etc/apache2/apache2.conf:
  file:
    - managed
    - source: salt://httpd/httpd.conf
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      {% if grains['os_family'] == 'RedHat' %}
      - service: httpd
      {% else %}
      - service: apache2
      {% endif %}

/etc/apache2/sites-enabled/000-default.conf:
  file:
    - managed
    - source: salt://httpd/000-default.conf
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      {% if grains['os_family'] == 'RedHat' %}
      - service: httpd
      {% else %}
      - service: apache2
      {% endif %}

/var/www/html:
  file.directory:
    - user: root
    - group: root
    - mode: 755
/var/www/html/index.html:
  file:
    - managed
    - source: salt://httpd/index.html
    - user: root
    - group: root
    - mode: 644
