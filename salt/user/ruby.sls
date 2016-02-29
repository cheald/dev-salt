include: [rvm]

{% set user = salt["pillar.get"]("user:name") %}
{% for name, config in salt["pillar.get"]("user:rubies", {}).iteritems() %}
{{name}}:
  rvm.installed:
    - user: {{ user }}
    - default: {{ config.get("default", "false") }}

{% for gem in config.get("gems") %}
{{name}}-{{gem}}:
  gem.installed:
    - name: {{ gem }}
    - user: {{ user }}
    - ruby: {{ name }}
{% endfor %}
{% endfor %}