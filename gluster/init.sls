initial:
  pkg.installed:
    - refresh: True
    - pkgs:
      - lvm2
      - python-pip
      - xfsprogs
{%- if grains['os_family'] == 'Debian' %}
      - python-software-properties
      - python-pycurl
{% endif %}
{%- if grains['os_family'] == 'RedHat' %}
      - bind-utils
{% endif %}
    - require_in:
{%- if grains['os_family'] == 'Debian' %}
      - pkgrepo: semiosis/ubuntu-glusterfs-3.4
{% endif %}
      - blockdev: /dev/vglocal00/gluster
      - pip: rackspace-novaclient

  pip:
    - installed
    - name: rackspace-novaclient
    - reload_modules: true

  cloud.volume_present:
    - provider: my-nova
    - name: {{ grains['id'] }}-volume
    - size: 100
    - voltype: SSD
    - require:
      - pip: rackspace-novaclient

attach-block-devices:
  cloud.volume_attached:
    - name: {{ grains['id'] }}-volume
    - server_name: {{ grains['id'] }}
    - provider: my-nova
    - device: /dev/xvdb
    - require_in:
      - lvm: /dev/xvdb
  
  lvm.pv_present:
    - name: /dev/xvdb
    - require_in:
      - lvm: vglocal00

volume-group:
  lvm.vg_present:
    - name: vglocal00
    - devices: /dev/xvdb
    - require_in:
      - lvm: gluster

{%- if grains['os_family'] == 'Debian' %}
  pkgrepo.managed:
    - ppa: semiosis/ubuntu-glusterfs-3.4
{% endif %}
{%- if grains['os_family'] == 'RedHat' %}
  file.managed:
    - name: /etc/yum.repos.d/gluster-epel.repo
    - source: http://download.gluster.org/pub/gluster/glusterfs/3.4/LATEST/CentOS/glusterfs-epel.repo
    - source_hash: md5=4a8162856b6be29475e1e6a56d597fe7
{% endif %}
    - require_in:
      - pkg: glusterfs-server

  pkg.latest:
    - name: glusterfs-server
    - refresh: True

{%- if grains['os_family'] == 'RedHat' %}
  service.running:
    - name: glusterd
    - enable: True
    - requre:
      - pkg: glusterfs-server
{% endif %}

final-directory:
  lvm.lv_present:
    - name: gluster
    - vgname: vglocal00
    - extents: +100%FREE
    - require_in:
      - blockdev: /dev/vglocal00/gluster

  cmd.run:
    - name: vgchange -ay
    - unless: vgs vglocal00
    - require:
      - lvm: gluster
    - require_in:
      - blockdev: /dev/vglocal00/gluster

  mount.mounted:
    - name: /srv/gluster
    - device: /dev/vglocal00/gluster
    - fstype: xfs
    - mkmnt: True
 
  blockdev.formatted:
    - name: /dev/vglocal00/gluster
    - fs_type: xfs
    - inode_size: 512
    - require_in:
      - mount: /srv/gluster

  file.directory:
    - name: /srv/gluster/drive1
    - user: root
    - group: root
    - mode: 755
    - require:
      - mount: /srv/gluster
