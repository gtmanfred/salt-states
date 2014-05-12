stop-volume:
  cmd.run:
    - name: echo Y | gluster volume stop work
    - onlyif: gluster volume status work
    - order: 1

remove-volume:
  cmd.run:
    - name: echo Y | gluster volume delete work
    - onlyif: gluster volume info work
    - watch:
      - cmd: stop-volume
