FROM ubuntu:18.04
MAINTAINER Robson Jr "http://robsonjr.com.br"

ENV DEBIAN_FRONTEND noninteractive
ENV TZ=America/Fortaleza

RUN set -ex \
    \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        sudo gnupg curl wget ca-certificates apt-transport-https \
    \
    && `# setup locale` \
    && apt-get install -y --no-install-recommends locales \
    && sed -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' -i /etc/locale.gen \
    && locale-gen \
    \
    && `# setup timezone` \
    && apt-get install -y --no-install-recommends \
        tzdata \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    \
    && ` # install handbrake and dependencies ` \
    && apt-get install -y handbrake-cli \
        mediainfo \
        jq \
    \
    && `# clean apt-get` \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the locale
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV SHELL /bin/bash

ENV HOME /home/handbrake-mediaencoder
RUN useradd --create-home --shell /bin/bash --home-dir $HOME handbrake-mediaencoder \
    && echo "handbrake-mediaencoder ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/handbrake-mediaencoder \
    && chmod 0440 /etc/sudoers.d/handbrake-mediaencoder
USER handbrake-mediaencoder

ADD docker-entrypoint.sh    /
ADD assets/filesystem/      /
ENTRYPOINT ["/docker-entrypoint.sh"]