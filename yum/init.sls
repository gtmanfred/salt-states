/etc/yum.repo.d/epel-testing.repo:
  file.managed:
    - source: salt://yum/epel-testing.repo
    - order: 1
