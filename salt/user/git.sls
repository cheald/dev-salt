{% set user = salt["pillar.get"]("user:name") %}
/home/{{user}}//.gitconfig:
  file.managed:
    - user: {{ user }}
    - group: {{ user }}
    - content: |
        [user]
          email = {{ salt["pillar.get"]("user:email") }}
          name = {{ salt["pillar.get"]("user:fullname") }}
        [color]
          diff = auto
          status = auto
        [push]
          default = simple
