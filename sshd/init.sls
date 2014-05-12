sshd_config_port_22345:
  file.append:
    - name: /etc/ssh/sshd_config
    - text: 'Port 2234 ## SALT'
    - watch_in:
      - service: sshd

sshd:
  service.running
