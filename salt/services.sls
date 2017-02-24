redis:
  pkg.installed:
    - fromrepo: {{ salt["pillar.get"]("redis:repo")}}
  service.running:
    - enable: true

redis-slave-selinux:
  cmd.run:
    - name: semanage port -a -t redis_port_t -p tcp 6389

/usr/lib/systemd/system/redis@.service:
  file.rename:
    - source: /usr/lib/systemd/system/redis.service
    - require:
      - pkg: redis

percona-release:
  pkg.installed:
    - sources:
      - percona-release: {{ salt["pillar.get"]("percona:repo_package")}}

Percona-Server-MongoDB:
  pkg.installed:
    - fromrepo: percona-release-x86_64
    - require:
      - pkg: percona-release
  service.running:
    - name: mongod
    - enable: true

Percona-Server-server-55:
  pkg.installed:
    - pkgs:
      - Percona-Server-server-55
      - Percona-Server-devel-55
      - Percona-Server-client-55
    - fromrepo: percona-release-x86_64
    - require:
      - pkg: percona-release
  service.running:
    - name: mysql
    - enable: true

{% if grains['os_family'] == "RedHat" %}
rabbitmq-signing-key:
  cmd.run:
    - name: rpm --import https://www.rabbitmq.com/rabbitmq-signing-key-public.asc
    - unless: "rpm -q gpg-pubkey --qf '%{name}-%{version}-%{release} --> %{summary}\n'  | grep RabbitMQ"
{% endif %}

rabbitmq-server:
  pkg.installed:
    - require:
      - cmd: rabbitmq-signing-key
  service.running:
    - enable: true

elasticsearch:
  pkg.installed:
    - sources:
      - elasticsearch: {{ salt["pillar.get"]("elasticsearch:package") }}
  service.running:
    - enable: true
