# -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
initial-accept:
  iptables.append:
    - table: filter
    - chain: INPUT
    - match: state
    - connstate: RELATED,ESTABLISHED
    - jump: ACCEPT
    - order: 1

# -A INPUT -p icmp -j ACCEPT
icmp:
  iptables.append:
    - table: filter
    - chain: INPUT
    - proto: icmp
    - icmp-type: '0'
    - jump: ACCEPT

# -A INPUT -i lo -j ACCEPT
loopback:
  iptables.append:
    - table: filter
    - chain: INPUT
    - in-interface: lo
    - jump: ACCEPT

ssh:
  iptables.append:
    - table: filter
    - chain: INPUT
    - match: state
    - connstate: NEW
    - proto: tcp
    - dport: 22
    - jump: ACCEPT

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
