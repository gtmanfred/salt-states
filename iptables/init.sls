# -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
initial-accept:
  iptables.append:
    - table: filter
    - chain: INPUT
    - match: state
    - connstate: RELATED,ESTABLISHED
    - j: ACCEPT
    - order: 1

# -A INPUT -p icmp -j ACCEPT
icmp:
  iptables.append:
    - table: filter
    - chain: INPUT
    - proto: icmp
    - icmp-type: '0'
    - j: ACCEPT

# -A INPUT -i lo -j ACCEPT
loopback:
  iptables.append:
    - table: filter
    - chain: INPUT
    - i: lo
    - j: ACCEPT

ssh:
  iptables.append:
    - table: filter
    - chain: INPUT
    - match: state
    - connstate: NEW
    - proto: tcp
    - dport: 22
    - j: ACCEPT

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

last:
  iptables.append:
    - table: filter
    - chain: INPUT
    - j: DROP
    - order: last
  

dante-fw:
  iptables.insert:
    - position: 1
    - table: filter
    - chain: INPUT
    - match:
      - state
      - comment
    - comment: "Allow Socks5 connections to dante"
    - j: ACCEPT
    - connstate: NEW,ESTABLISHED
    - dport: 1080
    - proto: tcp
    - save: True


