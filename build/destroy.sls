destroyme:
  module.run:
    - name: event.fire_master
    - data:
        package: {{ grains['host'] }}
        name: {{ grains['localhost'] }}
    - tag: 'salt/minion/{{ grains['localhost'] }}/destroyme'
    - order: 6
