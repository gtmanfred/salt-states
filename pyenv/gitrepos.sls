pyenv git repos:
  git.latest:
    - names:
      - git://github.com/yyuu/pyenv.git:
        - target: /usr/local/pyenv
      - git://github.com/yyuu/pyenv-virtualenv.git:
        - target: /usr/local/pyenv/plugins/pyenv-virtualenv

  file.managed:
    - name: /etc/profile.d/pyenv.sh
    - contents: |
        export PYENV_ROOT="$HOME/.pyenv"
        export PYENV_VIRTUALENV_DISABLE_PROMPT=0

  cmd.run:
    - name: cp -R -s -v /usr/local/pyenv/bin /usr/local/pyenv/plugins/*/bin /usr/local
    - onchanges:
      - git: pyenv git repos
