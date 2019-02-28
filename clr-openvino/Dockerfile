#
# The hivemq server based on Clear Linunx container OS.
#

FROM clearlinux
MAINTAINER bin.yang@intel.com

ARG swupd_args

ENV TINI_VERSION v0.18.0

RUN swupd update $swupd_args
RUN swupd bundle-add sudo vim curl unzip computer-vision-basic $swupd_args
RUN rm -rf /var/lib/swupd

RUN mkdir -p /etc/sudoers.d/
RUN echo "%root ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/root

RUN mkdir -p /usr/local/bin
RUN curl -fkSL "https://github.com/krallin/tini/releases/download/$TINI_VERSION/tini" -o /usr/local/bin/tini
RUN chmod +x /usr/local/bin/tini

RUN mkdir -p /opt/openvino
COPY clr-openvino/opt /opt
RUN chmod +x /opt/openvino/intel_models_download.sh
RUN /opt/openvino/intel_models_download.sh

ENTRYPOINT ["/usr/local/bin/tini", "-g", "--"]
CMD ["/bin/bash"]
