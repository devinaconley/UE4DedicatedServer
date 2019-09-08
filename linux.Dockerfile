# docker image to run test on simple dedicated server
FROM ubuntu:18.04
MAINTAINER devin@monodrive.io

ENV DEBIAN_FRONTEND noninteractive

# setup pre-reqs (h/t adamrehn/ue4-docker)
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
    build-essential \
    ca-certificates \
    curl \
    git \
    tzdata \
    xdg-user-dirs \
    unzip \
    zip

# include pre-built package
COPY . /home/server
RUN chmod -R a+x /home/server

# expose ports
EXPOSE 7777/udp

# user setup
RUN useradd -m -s /bin/bash -G sudo serveruser
RUN chown -R serveruser:serveruser /home/server

# runtime
USER serveruser
WORKDIR /home/server
CMD ./UE4DedicatedServerServer.sh
