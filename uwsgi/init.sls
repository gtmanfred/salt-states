uwsgi-packages:
  pkg.installed:
    - names:
      - python-devel
      - python-pip

uwsgi:
  pip.installed:
    - require:
      - pkg: python-pip
