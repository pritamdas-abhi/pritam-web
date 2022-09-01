FROM centos:7
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*; \
rm -f /etc/systemd/system/*.wants/*; \
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*; \
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]
RUN yum -y install epel-release && yum clean all
RUN yum -y install httpd mod_ssl lsof tree && yum clean all && systemctl enable httpd.service
COPY timer /var/www/html/timer
COPY conf/pritam-site.conf /etc/httpd/conf.d/pritam-site.conf
EXPOSE 80 8080
ENTRYPOINT ["/usr/sbin/init"]
CMD ["systemctl start httpd.service"]
