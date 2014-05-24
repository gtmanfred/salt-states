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
    - bricks:
       - one:/srv/gluster/drive1
       - two:/srv/gluster/drive1
       - three:/srv/gluster/drive1
       - four:/srv/gluster/drive1
       - five:/srv/gluster/drive1
       - six:/srv/gluster/drive1
       - seven:/srv/gluster/drive1
       - eight:/srv/gluster/drive1
    - replica: 2
    - start: True

gluster-started:
  glusterfs.started:
    - name: work


