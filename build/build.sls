git://code.gtmanfred.com/saltpkgbuilds:
  git.latest:
    - rev: master
    - target: /srv/git/
    - order: 3

make package:
  cmd.run:
    - name: extra-x86_64-build
    - user: root
    - group: root
    - cwd: /srv/git/{{ grains['host'] }}/
    - quiet: True
    - order: 4

