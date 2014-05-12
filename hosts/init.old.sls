{%- set fqdn = grains['id'] %}
{%- set addrs = salt['mine.get']('*', 'network.ip_addrs') %}

{%- if addrs is defined %}
{%- set if = grains['maintain_hostsfile_interface'] %}

{%- for name, addrlist in addrs.items() %}
{%- set short_name = name.split('.') | first %}
{{ name }}-host-entry:
  host.present:
    - ip: {{ addrlist[0] }}
    - names:
      - {{ name }}
{%- if short_name != name and salt['pillar.get']('hostsfile:generate_shortname', True) %}
      - {{ short_name }}
{%- endif %}

{% endfor %}

{% endif %}
