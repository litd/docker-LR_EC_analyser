# % Last Change: Sun Sep 17 12:34:28 AM 2023 CDT
# Base Image
FROM debian:10

# File Author / Maintainer
MAINTAINER Tiandao Li <litd99@gmail.com>

# Installation
RUN apt-get update --fix-missing && \
    apt-get install -y \
    build-essential \
    curl \
    default-jre \
    git \
    locales \
    nodejs \
    npm \
    python \
    python-dev \
    python-pip \
    r-base \
    samtools \
    xvfb && \
    locale-gen en_US.UTF-8 && \
    curl -fsSL http://regmedsrv1.wustl.edu/Public_SPACE/litd/Public_html/tmp/requirements_venv.txt -o /opt/requirements_venv.txt && \
    pip install -r /opt/requirements_venv.txt && \
    pip install Twisted==18.4.0 && \
    npm install http-server@0.11.1 && \
    npm install electron@1.8.4 && \
    git clone --recursive --branch avoid_orca --single-branch https://gitlab.com/leoisl/LR_EC_analyser && \
    apt-get clean all && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/log/dpkg.log /var/tmp/*

ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# set timezone, debian and ubuntu
RUN ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime && \
	echo "America/Chicago" > /etc/timezone

ENTRYPOINT [ "python", "/LR_EC_analyser/run_LR_EC_analyser.py" ]

