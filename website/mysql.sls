database:
  mysql_database.present:
    - name: {{ salt['pillar.get']('mysql:wordpress:database', '') }}
    - connection_user: root
    - connection_pass: {{ salt['pillar.get']('mysql:root-password', '') }}
    - requires:
      - service: mysql

{{ salt['pillar.get']('mysql:wordpress:user', '') }}:
  mysql_user.present:
    - host: {{ salt['pillar.get']('mysql:wordpress:host', '') }}
    - password: {{ salt['pillar.get']('mysql:wordpress:password', '') }}
    - connection_user: root
    - connection_pass: {{ salt['pillar.get']('mysql:root-password', '') }}
    - requires:
      - service: mysql

{{ salt['pillar.get']('mysql:wordpress:user', '') }}_{{ salt['pillar.get']('mysql:wordpress:database', '') }}:
  mysql_grants:
    - present
    - grant: all
    - database: {{ salt['pillar.get']('mysql:wordpress:database', '') }}.*
    - user: {{ salt['pillar.get']('mysql:wordpress:user', '') }}
    - host: {{ salt['pillar.get']('mysql:wordpress:host', '') }}
    - connection_user: root
    - connection_pass: {{ salt['pillar.get']('mysql:root-password', '') }}
    - requires:
      - service: mysql
