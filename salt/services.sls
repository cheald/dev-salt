redis:
  pkg.installed:
    - fromrepo: epel
  service.running:
    - enable: true

percona-release:
  pkg.installed:
    - sources:
      - percona-release: http://www.percona.com/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm

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

rabbitmq-signing-key:
  cmd.run:
    - name: rpm --import https://www.rabbitmq.com/rabbitmq-signing-key-public.asc
    - unless: "rpm -q gpg-pubkey --qf '%{name}-%{version}-%{release} --> %{summary}\n'  | grep RabbitMQ"

rabbitmq-server:
  pkg.installed:
    - require:
      - cmd: rabbitmq-signing-key
  service.running:
    - enable: true

elasticsearch:
  pkg.installed:
    - sources:
      - elasticsearch: https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.5.noarch.rpm
  service.running:
    - enable: true
