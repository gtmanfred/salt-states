database:
  mysql_database.present:
    - name: {{ salt['pillar.get']('website:wordpress:database', '') }}
    - connection_user: root
    - connection_pass: {{ salt['pillar.get']('mysql:server:root_password', '') }}
    - requires:
      - service: mysql

{{ salt['pillar.get']('website:wordpress:user', '') }}:
  mysql_user.present:
    - host: {{ salt['pillar.get']('website:wordpress:host', '') }}
    - password: {{ salt['pillar.get']('website:wordpress:password', '') }}
    - port: {{ salt['pillar.get']('website:wordpress:port', '3306') }}
    - connection_user: root
    - connection_pass: {{ salt['pillar.get']('mysql:server:root_password', '') }}
    - requires:
      - service: mysql

{{ salt['pillar.get']('website:wordpress:user', '') }}_{{ salt['pillar.get']('website:wordpress:database', '') }}:
  mysql_grants:
    - present
    - grant: all
    - database: {{ salt['pillar.get']('website:wordpress:database', '') }}.*
    - user: {{ salt['pillar.get']('website:wordpress:user', '') }}
    - host: {{ salt['pillar.get']('website:wordpress:host', '') }}
    - connection_user: root
    - connection_pass: {{ salt['pillar.get']('mysql:server:root_password', '') }}
    - requires:
      - service: mysql
