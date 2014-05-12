#saltmaster:
#  match: 'salt*'
#  sls:
#    - cloud.gluster

highstate-gluster:
  match: '*gluster.gtmanfred.com'
#  require:
#    - saltmaster

create-cluster:
  match: 'G@gluster:master'
  sls:
    - gluster.master
  require:
    - highstate-gluster

highstate-mount:
  match: 'mount*'
  require:
    - create-cluster
