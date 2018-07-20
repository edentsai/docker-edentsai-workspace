FROM phusion/baseimage:0.10.1

LABEL maintainer="Eden Tsai <edentsai231@gmail.com>"

USER root

# Initial locale.
RUN DEBIAN_FRONTEND="noninteractive"
RUN locale-gen "en_US.UTF-8"
ENV LANGUAGE="en_US.UTF-8"
ENV LC_ALL="en_US.UTF-8"
ENV LC_CTYPE="en_US.UTF-8"
ENV LANG="en_US.UTF-8"
ENV TERM="xterm"
