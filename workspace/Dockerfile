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

RUN apt-get update \
    && apt-get install --yes \
        "apt-transport-https" \
        "bc" \
        "build-essential" \
        "ca-certificates" \
        "curl" \
        "dnsutils" \
        "gcal" \
        "gcc" \
        "htop" \
        "httping=2.4-*" \
        "imagemagick=8:6.8.*" \
        "iotop" \
        "iputils-ping" \
        "jq=1.5*" \
        "less" \
        "libcurl4-openssl-dev" \
        "libedit-dev" \
        "libffi-dev" \
        "libsqlite3-dev" \
        "libssl-dev" \
        "libxml2-dev" \
        "make" \
        "most" \
        "mtr" \
        "mysql-client-5.7" \
        "mytop" \
        "netcat" \
        "pkg-config" \
        "rsync" \
        "screen" \
        "silversearcher-ag" \
        "software-properties-common" \
        "sqlite3" \
        "sshpass" \
        "sudo" \
        "sysstat" \
        "tar" \
        "telnet" \
        "tree" \
        "tzdata" \
        "unzip" \
        "wget" \
        "whois" \
        "xz-utils" \
        "zsh=5.1.*" \
    # Install Vim 8.1 (https://launchpad.net/~jonathonf/+archive/ubuntu/vim)
    && add-apt-repository --yes "ppa:jonathonf/vim" \
    && apt-get update \
    && apt-get install --yes "vim=2:8.1.*" \
    # Install Git 2.18 (https://launchpad.net/~git-core/+archive/ubuntu/ppa)
    && add-apt-repository --yes "ppa:git-core/ppa" \
    && apt-get update \
    && apt-get install --yes "git=1:2.18.*" \
    # Clean unnecessary files
    && apt-get clean \
    && rm --recursive --force /var/lib/apt/lists/* \
    && rm --recursive --force /var/tmp/* \
    && rm --recursive --force /tmp/*

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
