remove-volume:
  cmd.run:
    - name: gluster volume stop work force
    - onlyif: gluster volume status work

stop-volume:
  cmd.run:
    - name: gluster volume delete work force
    - require:
      - cmd: remove-volume

unmount-volume:
  service.dead:
    - name: glusterfs-server
    - enabled: False
    - require:
      - cmd: stop-volume
  
  mount.unmounted:
    - name: /srv/gluster
    - require:
      - cmd: stop-volume

  lvm.vg_absent:
    - name: vglocal00
    - require:
      - mount: /srv/gluster

detach-volume:
  lvm.pv_absent:
    - name: /dev/xvdb
    - require:
      - mount: unmount-volume

#  cloud.volume_detached:
#    - provider: my-nova
#    - name: {{ grains['localhost'] }}-volume
#    - require:
#      - lvm: /dev/xvdb
#
#delete-volume:
#  cloud.volume_absent:
#    - provider: my-nova
#    - name: {{ grains['localhost'] }}-volume
#    - require:
#      - cloud: detach-volume
