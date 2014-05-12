{%- set info = salt['cloud.query']('list_nodes')['my-nova']['nova'] %}

{%- if info is defined %}

{%- set if = grains['maintain_hostsfile_interface'] %}

{%- for name, interfaces in info.items() %}
{%- set short_name = name.split('.') | first %}
{{ name }}-host-entry-cloud:
  host.present:
    - ip: {{ interfaces['private_ips'][0] }}
    - names:
      - {{ name }}
{%- if short_name != name and salt['pillar.get']('hostsfile:generate_shortname', True) %}
      - {{ short_name }}
{%- endif %}

{% endfor %}

{% endif %}
