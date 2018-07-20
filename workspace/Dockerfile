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

# Add a non-root user to prevent files being created with root permissions on host machine.
USER root
ARG USERNAME="user"
ARG PASSWORD="secret"
ARG PUID="1000"
ARG PGID="1000"

RUN if [ "${USERNAME}" != "root" ]; then \
        groupadd --gid "${PGID}" "${USERNAME}" \
            && useradd --create-home \
                --groups "docker_env" \
                --uid "${PUID}" \
                --gid "${USERNAME}" \
                "${USERNAME}" \
            && echo "${USERNAME}:${PASSWORD}" | chpasswd \
            && adduser "${USERNAME}" "sudo"; \
    fi
