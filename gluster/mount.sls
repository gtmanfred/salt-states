mountpkgs:
  pkg.installed:
    - refresh: True
    - pkgs:
{%- if grains['os_family'] == 'Debian' %}
      - python-software-properties
      - python-pycurl
    - require_in:
      - pkgrepo: semiosis/ubuntu-glusterfs-3.5
{% endif %}
  
gluster-pkgs:
{%- if grains['os_family'] == 'Debian' %}
  pkgrepo.managed:
    - ppa: semiosis/ubuntu-glusterfs-3.5
    - require_in:
      - pkg: glusterfs-client

  pkg.latest:
    - name: glusterfs-client
    - refresh: True
{%- endif %}
{%- if grains['os_family'] == 'RedHat' %}
  file.managed:
    - name: /etc/yum.repos.d/gluster-epel.repo
    - source: http://download.gluster.org/pub/gluster/glusterfs/3.4/LATEST/CentOS/glusterfs-epel.repo
    - source_hash: md5=4a8162856b6be29475e1e6a56d597fe7
    - require_in:
      - pkg: glusterfs-fuse

  pkg.latest:
    - name: glusterfs-fuse
    - refresh: True
{%- endif %}
    - require_in:
      - mount: /srv

mount-gluster-fs:
  mount.mounted:
    - type: glusterfs
    - name: /srv
    - device: one:/work
    - fstype: glusterfs
    - require:
      - sls: hosts
