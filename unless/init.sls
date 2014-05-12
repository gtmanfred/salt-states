test unless:
  cmd.run:
    - name: echo 'test' > /tmp/test
    - creates:
      - /etc/shadows
