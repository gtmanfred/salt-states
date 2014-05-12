salt-minion:
  git.latest:
    - name: git://github.com/{{salt['pillar.get']('salt:repo', 'saltstack')}}/salt.git
    - rev: {{ salt['pillar.get']('salt:branch', 'develop') }}
    - target: /salt

  cmd.wait:
    - name: python setup.py install
    - cwd: /salt
    - watch:
      - git: git://github.com/{{salt['pillar.get']('salt:repo', 'saltstack')}}/salt.git
    - require_in:
      - module: saltutil.sync_all

  module.run:
    - name: saltutil.sync_all
