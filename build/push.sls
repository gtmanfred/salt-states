push to master:
  module.run:
    - name: cp.push_dir
    - path: /srv/{{ grains['host'] }}
    - glob: '*.pkg.tar.xz'
    - order: 5 

#pull to repos:
#  module.run:
#    - name: event.fire_master
#    - data:
#      - name: {{ grains['host'] }}
#    - tag: salt/minion/copyfiles
#    - order: 6
