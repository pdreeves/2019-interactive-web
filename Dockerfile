# Pull from centos/systemd
FROM centos/systemd

LABEL maintainer="iso-se@list.arizona.edu"

# Install packages needed for lab across all containers
RUN yum install python3 openssh-server openssh-clients sshpass initscripts -y; \
  systemctl enable sshd.service; \
  yum clean all; \
  rm -rf /var/cache/yum

# Configure SSH settings
RUN sed -i 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config; \
  adduser centos; \
  echo "centos" | passwd --stdin centos

# expost 22 for SSH access
EXPOSE 22 80

CMD ["/usr/sbin/init"]
