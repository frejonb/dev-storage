FROM debian:buster

COPY BLANK.config/ /root/BLANK.config
COPY BLANK.gitconfig .zshrc .kubectl_aliases install-packages.sh /root/
# RUN ./root/install-packages.sh
