# -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
initial-accept:
  iptables.append:
    - &defaults 
        - table: filter
        - chain: INPUT
        - jump: ACCEPT
    - <<: *defaults
    - match: state
    - connstate: RELATED,ESTABLISHED
    - order: 1

# -A INPUT -p icmp -j ACCEPT
icmp:
  iptables.append:
    - <<: *defaults
    - proto: icmp
    - icmp-type: '0'

# -A INPUT -i lo -j ACCEPT
loopback:
  iptables.append:
    - <<: *defaults
    - in-interface: lo

ssh:
  iptables.append:
    - <<: *defaults
    - match: state
    - connstate: NEW
    - proto: tcp
    - dport: 22

input:
  iptables.set_policy:
    - table: filter
    - chain: INPUT
    - policy: ACCEPT

forward:
  iptables.set_policy:
    - table: filter
    - chain: FORWARD
    - policy: ACCEPT

output:
  iptables.set_policy:
    - table: filter
    - chain: OUTPUT
    - policy: ACCEPT

last:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: DROP
    - order: last

{%- if 'gluster' in grains['localhost'] %}
include:
  - .gluster
{% endif %}
