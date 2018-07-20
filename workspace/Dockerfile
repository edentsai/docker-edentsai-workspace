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
    # Install Tig 2.2 (https://launchpad.net/~aguignard/+archive/ubuntu/ppa)
    && add-apt-repository --yes "ppa:aguignard/ppa" \
    && apt-get update \
    && apt-get install --yes "tig=2.2-*" \
    # Install Tmux-next 2.7 (https://launchpad.net/~pi-rho/+archive/ubuntu/dev)
    && add-apt-repository --yes "ppa:pi-rho/dev" \
    && apt-get update \
    && apt-get install --yes "tmux-next=2.7~*" \
    && ln --verbose --symbolic "/usr/bin/tmux-next" "/usr/local/bin/tmux" \
    # Install Mosh 1.3 (https://launchpad.net/~keithw/+archive/ubuntu/mosh)
    && add-apt-repository --yes "ppa:keithw/mosh" \
    && apt-get update \
    && apt-get install --yes "mosh=1.3.*" \
    # Install Redis tools 4.0 (https://launchpad.net/~chris-lea/+archive/ubuntu/redis-server)
    && add-apt-repository --yes "ppa:chris-lea/redis-server" \
    && apt-get update \
    && apt-get install --yes "redis-tools=5:4.0.*" \
    # Install PostgreSQL Client 10
    && add-apt-repository "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" \
    && wget --quiet --output-document - "https://www.postgresql.org/media/keys/ACCC4CF8.asc" | apt-key add - \
    && apt-get update \
    && apt-get install --yes "postgresql-client-10" \
    # Install Python 2.7
    &&  apt-get install --yes \
        "python-setuptools=20.7.*" \
        "python2.7=2.7.*" \
        "python2.7-minimal=2.7.*" \
        "python-pip=8.1.*" \
    && python -m pip install --upgrade "pip==10.0.*" \
    && python -m pip install --upgrade "virtualenv==16.0.*" \
    # Install PHP 7.2 (https://launchpad.net/~ondrej/+archive/ubuntu/php)
    && add-apt-repository --yes "ppa:ondrej/php" \
    && apt-get update \
    && apt-get install --yes \
        --allow-downgrades \
        --allow-remove-essential \
        --allow-change-held-packages \
        "php7.2-cli" \
        "php7.2-common" \
        "php7.2-curl" \
        "php7.2-intl" \
        "php7.2-json" \
        "php7.2-xml" \
        "php7.2-mbstring" \
        "php7.2-mysql" \
        "php7.2-pgsql" \
        "php7.2-sqlite" \
        "php7.2-sqlite3" \
        "php7.2-zip" \
        "php7.2-bcmath" \
        "php7.2-memcached" \
        "php7.2-gd" \
        "php7.2-dev" \
        "php-imagick" \
        "php-xdebug" \
    # Install PHP Composer
    && curl "http://getcomposer.org/installer" | php \
    && chmod +x "composer.phar" \
    && mv --verbose "composer.phar" "/opt/composer" \
    && ln --verbose --symbolic "/opt/copmoser" "/usr/local/bin/composer" \
    # Clean unnecessary files
    && apt-get clean \
    && rm --recursive --force /var/lib/apt/lists/* \
    && rm --recursive --force /var/tmp/* \
    && rm --recursive --force /tmp/*

# Install Golang with specific version.
ARG GO_ROOT="/opt/go"
ARG GO_VERSION="1.10.3"
ARG GO_DOWNLOAD_BASENAME="go${GO_VERSION}.linux-amd64.tar.gz"
ARG GO_DOWNLOAD_URL="https://storage.googleapis.com/golang/${GO_DOWNLOAD_BASENAME}"
ENV GO_ROOT="${GO_ROOT}"
ENV PATH="${GO_ROOT}/bin:${PATH}"
RUN export GO_DIR="/opt/$(basename ${GO_DOWNLOAD_BASENAME} .tar.gz)" \
    && cd "/tmp" \
    && curl --output "${GO_DOWNLOAD_BASENAME}" "${GO_DOWNLOAD_URL}" \
    && tar --gzip --extract --file "${GO_DOWNLOAD_BASENAME}" \
    && mv --verbose "go" "${GO_DIR}" \
    && ln --verbose --symbolic "${GO_DIR}" "${GO_ROOT}" \
    && rm --verbose "${GO_DOWNLOAD_BASENAME}"

# Install Google Cloud SDK
ARG GCLOUD_ROOT="/opt/google-cloud-sdk"
ENV PATH="${GCLOUD_ROOT}/bin:${PATH}"
RUN export CLOUDSDK_INSTALL_DIR="$(dirname ${GCLOUD_ROOT})" \
    && export CLOUDSDK_CORE_DISABLE_PROMPTS="1" \
    && curl "https://sdk.cloud.google.com" | bash \
    && ln --verbose --symbolic "${GCLOUD_ROOT}/completion.bash.inc" "/usr/share/bash-completion/completions/gcloud" \
    # Install kubectl via Google Cloud SDK
    && gcloud components update \
    && gcloud components install --quiet "kubectl" \
    # Install kubectx and kubens (https://github.com/ahmetb/kubectx)
    && git clone "https://github.com/ahmetb/kubectx" "/opt/kubectx" \
    && ln --verbose --symbolic "/opt/kubectx/kubectx" "/usr/local/bin/kubectx" \
    && ln --verbose --symbolic "/opt/kubectx/completion/kubectx.bash" "/usr/share/bash-completion/completions/kubectx" \
    && ln --verbose --symbolic "/opt/kubectx/kubens" "/usr/local/bin/kubens" \
    && ln --verbose --symbolic "/opt/kubectx/completion/kubens.bash" "/usr/share/bash-completion/completions/kubens"

# Install speedtest-cli 2.0.0 (https://raw.githubusercontent.com/sivel/speedtest-cli)
ARG SPEEDTEST_CLI_VERSION=2.0.2
RUN curl --output "speedtest-cli" "https://raw.githubusercontent.com/sivel/speedtest-cli/${SPEEDTEST_CLI_VERSION}/speedtest.py" \
    && chmod +x "speedtest-cli" \
    && mv --verbose "speedtest-cli" "/opt/speedtest-cli" \
    && ln --verbose --symbolic "/opt/speedtest-cli" "/usr/local/bin/speedtest-cli"

# Set Timezone
ARG TIMEZONE="Asia/Taipei"
RUN if [ "${TIMEZONE}" != "" ]; then \
        export TIMEZONE_FILE="/usr/share/zoneinfo/${TIMEZONE}" \
            && cat "${TIMEZONE_FILE}" > /dev/null \
            && ln --verbose --symbolic --force "${TIMEZONE_FILE}" "/etc/localtime" \
            && echo "${TIMEZONE}" > "/etc/timezone"; \
    fi

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
