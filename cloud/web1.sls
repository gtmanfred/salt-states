web_profile:
  cloud.profile:
    - name: web1.gtmanfred.com
    - profile: ubuntu-1
    - require:
      - sls: cloud.redis1
      - sls: cloud.db1
