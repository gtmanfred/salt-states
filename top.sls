base:
  'os_family:RedHat':
    - match: grain
    - vim
  'os_family:Debian':
    - match: grain
    - base
    - hosts
    - iptables
  'db*':
    - mysql.server
    - mysql.client
    - mysql.python
    - website.mysql
  '*gluster*':
    - gluster
  'mounter*':
    - gluster.mount
  'web*':
    - httpd
    - php
    - website.wordpress
