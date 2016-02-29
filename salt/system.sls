base packages:
  pkg.installed:
    - pkgs:
      - vim-enhanced
      - git
      - libcurl-devel
      - libxml2-devel
      - libxslt-devel
      - wget
      - sysstat
      - bind-utils
      - java-1.8.0-openjdk-devel

# Entropy
haveged:
  pkg.installed: []
  service.running:
    - enable: true
