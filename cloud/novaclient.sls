git_novaclient:
  pkg.installed:
    - pkgs:
      - git
      - python-pip
      - sshpass

  pip.installed:
    - name: novaclient
    - editable: git://github.com/openstack/python-novaclient.git#egg=novaclient
    - require:
      - pkg: git_novaclient

rackspace-novaclient:
  pip.installed:
    - reload_modules: True
    - require:
      - pip: git_novaclient

  module.wait:
    - name: service.restart
    - m_name: salt-minion
    - watch:
      - pip: rackspace-novaclient
