FROM debian:bullseye

COPY install-packages.sh .
RUN ./install-packages.sh