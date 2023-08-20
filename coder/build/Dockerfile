FROM ubuntu:latest

RUN apt-get update \
	&& apt-get install -y \
	curl \
	git \
	sudo \
    nano \
	wget \
    && apt-get install -y build-essential

# Install Docker
RUN apt-get update -y \
    && apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    apt-transport-https \
    software-properties-common

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

USER ${USER}
WORKDIR /home/${USER}