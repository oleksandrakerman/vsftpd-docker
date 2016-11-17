# This container is for vsftpd
FROM centos:6.8

# Install vsftpd, pam_mysql, rsyslog.
RUN yum -y install vsftpd && \
  rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm && \
  yum -y install pam_mysql && \
  useradd --home /home/vsftpd --gid users -m --shell /bin/false vsftpd && \
  mkdir -p /home/vsftpd/users && \
  chown -R  vsftpd:users /home/vsftpd/users && \
  yum install -y rsyslog && \
  service rsyslog start && \
  rm -rf /var/cache/yum/*

# vsftpd/pam configs.
ADD pam_vsftpd /etc/pam.d/vsftpd
ADD vsftpd.conf /etc/vsftpd/vsftpd.conf
ADD create_dir.sh /usr/local/bin/create_dir.sh

# Share dir for other containers.
VOLUME /home/vsftpd/users

# Expose ports.
EXPOSE 21 50000 50001 50002 50003 50004 50005

# Run vsftpd.
CMD ["/usr/sbin/vsftpd", "/etc/vsftpd/vsftpd.conf"]

