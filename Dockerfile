# Pull from centos/systemd
FROM centos/systemd

LABEL maintainer="iso-se@list.arizona.edu"

# Install packages needed for lab across all containers
RUN yum install python3 openssh-server openssh-clients sshpass initscripts -y sudo; \
  systemctl enable sshd.service; \
  yum clean all; \
  rm -rf /var/cache/yum

# Configure SSH settings
RUN sed -i 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

# Add centos user account
RUN adduser centos; \
  echo "interactive" | passwd --stdin centos; \
  echo 'centos ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN yum remove iptables -y

RUN yum install telnet-server -y

# Add user account
RUN adduser secret

# expost 22 for SSH access
EXPOSE 22 80

CMD ["/usr/sbin/init"]
