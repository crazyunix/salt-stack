source:
  cmd.run:
    - name: "yum -y install http://www.percona.com/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm"
    - unless: test -f /etc/yum.repos.d/percona-release.repo
