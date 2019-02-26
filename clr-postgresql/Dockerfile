#
# The postgresql server based on Clear Linunx container OS.
#

FROM clearlinux
MAINTAINER bin.yang@intel.com

ARG swupd_args

RUN swupd update $swupd_args
RUN swupd bundle-add sudo postgresql $swupd_args
RUN rm -rf /var/lib/swupd

RUN mkdir -p /etc/sudoers.d/
RUN echo "%root ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/root

RUN install -d -m 0700 -opostgres -gpostgres /var/lib/pgsql/data
RUN install -d -m 0644 -opostgres -gpostgres /run/postgresql
RUN install -d -m 0700 -opostgres -gpostgres /run/postgresql
RUN sudo -u postgres /usr/bin/initdb -D /var/lib/pgsql/data -A trust

CMD ["/usr/bin/sudo", "-u", "postgres", "/usr/bin/postgres", "-D", "/var/lib/pgsql/data"]
EXPOSE 5432
