FROM debian:buster
EXPOSE 22
COPY docker-scripts/install-packages.sh /
RUN chmod +x /install-packages.sh && ./install-packages.sh

COPY docker-scripts/install-extra-packages.sh /
RUN chmod +x /install-extra-packages.sh && ./install-extra-packages.sh

COPY docker-scripts/docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

# Move container user files to a different folder
RUN mv /root /root-container && mkdir /root \
 && cp /root-container/.bashrc /root/.bashrc \
 && cp /root-container/.profile /root/.profile

ENTRYPOINT [ "sh", "/docker-entrypoint.sh" ]

WORKDIR /root
