uwsgi-packages:
  pkg.installed:
    - pkgs:
      - python-devel
      - python-pip

uwsgi:
  pip.installed:
    - require:
      - pkg: uwsgi-packages
