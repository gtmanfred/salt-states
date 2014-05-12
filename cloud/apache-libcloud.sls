apache-libcloud:
  file.managed:
    - source: salt://cloud/providers/rackspace.conf
    - name: /etc/salt/cloud.providers.d/rackspace.conf
