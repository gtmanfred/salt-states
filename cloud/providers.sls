/etc/salt/cloud:
  file.managed:
    - source: salt://cloud/providers/rackspace.conf
    - require_in:
      - sls: hosts
