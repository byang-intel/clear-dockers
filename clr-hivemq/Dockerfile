#
# The hivemq server based on Clear Linunx container OS.
#

FROM clearlinux
MAINTAINER bin.yang@intel.com

ARG swupd_args
ARG HIVEMQ_VERSION=3.3.4
ARG HIVEMQ_GID=10000
ARG HIVEMQ_UID=10000

ENV TINI_VERSION v0.18.0

RUN swupd update $swupd_args
RUN swupd bundle-add sudo vim curl unzip java-basic $swupd_args
RUN rm -rf /var/lib/swupd

RUN mkdir -p /etc/sudoers.d/
RUN echo "%root ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/root

ENV JAVA_OPTS "-XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:+UseNUMA"

RUN mkdir -p /usr/local/bin
RUN curl -fkSL "https://github.com/krallin/tini/releases/download/$TINI_VERSION/tini" -o /usr/local/bin/tini
RUN chmod +x /usr/local/bin/tini

# HiveMQ setup
RUN mkdir -p /opt/
COPY clr-hivemq/config.xml /opt/config.xml
RUN curl -k -L https://www.hivemq.com/releases/hivemq-${HIVEMQ_VERSION}.zip -o /opt/hivemq-${HIVEMQ_VERSION}.zip \
    && unzip /opt/hivemq-${HIVEMQ_VERSION}.zip  -d /opt/\
    && rm -f /opt/hivemq-${HIVEMQ_VERSION}.zip \
    && ln -s /opt/hivemq-${HIVEMQ_VERSION} /opt/hivemq \
    && mv /opt/config.xml /opt/hivemq-${HIVEMQ_VERSION}/conf/config.xml \
    && groupadd --gid ${HIVEMQ_GID} hivemq \
    && useradd -g hivemq -d /opt/hivemq -s /bin/bash --uid ${HIVEMQ_UID} hivemq \
    && chown -R hivemq:hivemq /opt/hivemq-${HIVEMQ_VERSION} \
    && chmod -R 777 /opt \
    && chmod +x /opt/hivemq/bin/run.sh

# Substitute eval for exec and replace OOM flag if necessary (for older releases). This is necessary for proper signal propagation
RUN sed -i -e 's|eval \\"java\\" "$HOME_OPT" "$JAVA_OPTS" -jar "$JAR_PATH"|exec "java" $HOME_OPT $JAVA_OPTS -jar "$JAR_PATH"|' /opt/hivemq/bin/run.sh && \
    sed -i -e "s|-XX:OnOutOfMemoryError='sleep 5; kill -9 %p'|-XX:+CrashOnOutOfMemoryError|" /opt/hivemq/bin/run.sh

# Make broker data persistent throughout stop/start cycles
VOLUME /opt/hivemq/data

# Persist log data
VOLUME /opt/hivemq/log

EXPOSE 1883

WORKDIR /opt/hivemq
USER ${HIVEMQ_UID}

ENTRYPOINT ["/usr/local/bin/tini", "-g", "--"]
CMD ["/opt/hivemq/bin/run.sh"]
