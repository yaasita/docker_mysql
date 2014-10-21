FROM debian:jessie
MAINTAINER yaasita

#apt
#ADD 02proxy /etc/apt/apt.conf.d/02proxy
RUN apt-get update
RUN apt-get upgrade -y

#ssh
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd/
RUN mkdir /root/.ssh
#ADD authorized_keys /root/.ssh/authorized_keys
RUN perl -i -ple 's/^(permitrootlogin\s)(.*)/\1yes/i' /etc/ssh/sshd_config
RUN echo root:root | chpasswd
CMD /usr/sbin/sshd -D

# locale
RUN apt-get install -y locales dialog
COPY etc/default/locale /etc/default/locale
COPY etc/locale.alias /etc/locale.alias
COPY etc/locale.gen /etc/locale.gen
COPY etc/localtime /etc/localtime
COPY etc/timezone /etc/timezone

# supervisor
RUN apt-get install -y supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 22 3306
CMD ["/usr/bin/supervisord"]

# mysql
RUN apt-get install -y vim git htop aptitude \
 x11-common mysql-server mysql-workbench x11-apps
