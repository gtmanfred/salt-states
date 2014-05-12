ruby-2.1.1:
  rvm.installed:
    - user: daniel
    - default: True

bundler:
  rvm.gemset_present:
    - ruby: ruby-2.1.1
    - user: daniel

  gem.installed:
    - user: daniel
    - names:
      - vagrant
      - bundler
