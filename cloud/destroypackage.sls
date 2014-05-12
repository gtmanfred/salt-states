destroy package:
  cloud.absent:
    - name: {{ pillar['old_minion'] }}
