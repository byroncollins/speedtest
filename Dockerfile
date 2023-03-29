FROM registry.access.redhat.com/ubi8

ENV USER_NAME speedtest
ENV HOME=/home/speedtest

RUN mkdir -p ${HOME}/bin \
    && dnf -y --nodocs install curl \
    && curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.rpm.sh | bash \
    && dnf -y --nodocs install speedtest \
    && cd ${HOME} \
    && /usr/bin/speedtest --accept-license --accept-gdpr \
    && dnf clean all \
    && rm -rf /var/cache/yum 

COPY entrypoint.sh ${HOME}/bin/

RUN chmod u+x ${HOME}/bin/entrypoint.sh \
    && chgrp -R 0 ${HOME} \
    && chmod -R g+wrx ${HOME} \
    && chmod -R g=u ${HOME} /etc/passwd

USER 10001

ENTRYPOINT exec ${HOME}/bin/entrypoint.sh