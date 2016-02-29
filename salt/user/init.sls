include:
  - zsh
  - user.git

{% set user = salt["pillar.get"]("user:name") %}
{{ user }}:
  user.present:
    - shell: /bin/zsh
