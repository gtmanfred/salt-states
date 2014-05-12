detach-volume:
  cloud.volume_detached:
    - provider: my-nova
    - name: {{ grains['localhost'] }}-volume
    - order: 1

delete-volume:
  cloud.volume_absent:
    - provider: my-nova
    - name: {{ grains['localhost'] }}-volume
    - order: 2
