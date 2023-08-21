FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ Asia/Tokyo
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8

RUN apt-get update \
	&& apt-get install -y \
	sudo init systemd apt-utils locales-all \
    tzdata locales \
    net-tools \
    lsb-release \
    curl wget \
	git nano

# set locale
RUN locale-gen ja_JP.UTF-8

# prepare for docker
RUN apt-get install -y \
    ca-certificates \
    gnupg \
    apt-transport-https \
    software-properties-common \
    && apt-get install -y build-essential

# Install Docker
RUN install -m 0755 -d /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
    && echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
        "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
        tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt-get update -y \
    && apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

RUN	apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# User settings
ARG USER=coder
RUN useradd --groups sudo --no-create-home --shell /bin/bash ${USER} \
	&& echo "${USER} ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/${USER} \
	&& chmod 0440 /etc/sudoers.d/${USER}

# run docker without sudo
RUN gpasswd -a ${USER} docker

USER ${USER}
WORKDIR /home/${USER}
