{%- set info = salt['cloud.query']('list_nodes')['my-nova']['nova'] %}
{%- if info is defined %}
{%- for name, interfaces in info.items() %}
{%- if 'gluster' in name or 'mount' in name %}
{{ name }}-gluster-iptables:
  iptables.append:
    - table: filter
    - chain: INPUT
    - match: state
    - connstate: NEW
    - proto: tcp
    - source: {{ interfaces['private_ips'][0] }}
    - jump: ACCEPT
{% endif %}
{% endfor %}
{% endif %}
