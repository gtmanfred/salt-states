vim:
  pkg:
    {% if grains['os_family'] == 'RedHat' %}
    - name: vim-enhanced
    {% else %}
    - name: vim
    {% endif %}
    - installed

/root/.vimrc:
  file:
    - managed
    - source: salt://vim/vimrc
    - user: root
    - group: root
    - mode: 644
