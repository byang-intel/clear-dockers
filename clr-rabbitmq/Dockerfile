#
# The postgresql server based on Clear Linunx container OS.
#

FROM clearlinux
MAINTAINER bin.yang@intel.com

ARG swupd_args

RUN swupd update $swupd_args
RUN swupd bundle-add sudo openstack-common $swupd_args
RUN rm -rf /var/lib/swupd

RUN mkdir -p /etc/sudoers.d/
RUN echo "%root ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/root

RUN install -d -m 0700 -orabbitmq -grabbitmq /var/lib/rabbitmq/
RUN install -d -m 0700 -orabbitmq -grabbitmq /var/log/rabbitmq

ENV LANG=C.UTF-8 LANGUAGE=C.UTF-8 LC_ALL=C.UTF-8
RUN mkdir -p /etc/rabbitmq/

#RUN rabbitmq-plugins enable --offline rabbitmq_management

CMD ["sudo", "-u", "rabbitmq", "RABBITMQ_PID_FILE=/var/lib/rabbitmq/pid", "/usr/sbin/rabbitmq-server"]
EXPOSE 4369 5671 5672 25672 15671 15672
