redis-server:
  pkg:
    - installed
  service:
    - running
    - watch:
      - file: /etc/redis/redis.conf

/etc/redis/redis.conf:
  file.comment:
    - regex: ^bind 127.0.0.1
    - require:
      - pkg: redis-server

#    - source: salt://redis/redis.conf
#    - user: root
#    - group: root
#    - mode: 0644
