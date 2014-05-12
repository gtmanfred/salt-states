cluster-peers:
  glusterfs.peered:
    - requre_in:
      - glusterfs.created: work
    - names:
      - one
      - two
      - three
      - four
      - five
      - six
      - seven
      - eight
    - require_in:
      - glusterfs: work

gluster-created:
  glusterfs.created:
    - name: work
    - brick: /srv/gluster/drive1
    - replica: True
    - count: 2
    - short: True
    - peers:
      - one
      - two
      - three
      - four
      - five
      - six
      - seven
      - eight

gluster-started:
  glusterfs.started:
    - name: work


