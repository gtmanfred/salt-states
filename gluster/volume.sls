volume_present:
  cloud.volume_present:
    - provider: my-nova
    - name: {{ grains['id'] }}-volume
    - size: 100
    - voltype: SSD
