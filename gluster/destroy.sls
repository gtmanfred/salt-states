unmount-volume:
  service.dead:
    - name: glusterfs-server
    - enable: False
  
  mount.unmounted:
    - name: /srv/gluster

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
