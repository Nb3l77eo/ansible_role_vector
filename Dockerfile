FROM ubuntu:latest
ENV MOLECULE_NO_LOG false
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y && apt install tar gcc make python3-pip libssl-dev ca-certificates \
    curl \
    gnupg \
    lsb-release -y
RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN curl -L http://downloadcontent.opensuse.org/repositories/home:/alvistack/xUbuntu_22.04/Release.key | apt-key add -
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN echo "deb http://downloadcontent.opensuse.org/repositories/home:/alvistack/xUbuntu_22.04/ /" | tee /etc/apt/sources.list.d/podman.list > /dev/null

RUN apt update -y && apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin containernetworking-dnsname containernetworking-plugins containernetworking-podman-machine podman -y

RUN mkdir /etc/docker/ && echo "{\n    \"storage-driver\": \"vfs\"\n}" >> /etc/docker/daemon.json
RUN echo "[storage]\ndriver = \"vfs\"" > /etc/containers/storage.conf


RUN echo "unqualified-search-registries = ['docker.io']\n[[registry]]\nprefix=\"docker.io\"\nlocation=\"docker.io\"" > /etc/containers/registries.conf
ENTRYPOINT service docker start && bash

ADD https://www.python.org/ftp/python/3.7.10/Python-3.7.10.tgz Python-3.7.10.tgz
RUN tar xf Python-3.7.10.tgz && cd Python-3.7.10/ && ./configure && make && make altinstall
ADD https://www.python.org/ftp/python/3.9.2/Python-3.9.2.tgz Python-3.9.2.tgz
RUN tar xf Python-3.9.2.tgz && cd Python-3.9.2/ && ./configure && make && make altinstall
RUN python3 -m pip install --upgrade pip && pip3 install tox selinux
RUN rm -rf Python-*
