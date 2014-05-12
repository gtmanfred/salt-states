cleanuppkg:
  pkg.purged:
    - name: sysvinit-tools
    - order: 1

buildpkgs:
  pkg.installed:
    - refresh: True
    - pkgs:
      - autoconf
      - automake
      - binutils
      - bison
      - fakeroot
      - file
      - findutils
      - flex
      - gawk
      - gcc
      - gettext
      - grep
      - groff
      - gzip
      - libtool
      - m4
      - make
      - pacman
      - patch
      - pkg-config
      - sed
      - sudo
      - texinfo
      - util-linux
      - which
      - devtools
    - order: 2

include:
  - build.build
  - build.push
  - build.destroy
