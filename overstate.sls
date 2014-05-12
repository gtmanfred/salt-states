saltmaster:
  match: 'salt-master'
  sls:
    - cloud.package

cloudinfo:
  match: '*'
  sls:
    - cloud.apache-libcloud

build:
  match: '*package.gtmanfred.com'
  require:
    - saltmaster

delete:
  match: 'dunst.package.gtmanfred.com'
  require:
    - build
  sls:
    - cloud.destroypackage
