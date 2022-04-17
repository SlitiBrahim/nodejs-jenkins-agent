FROM jenkins/ssh-agent:alpine
LABEL maintainer="SLITI Brahim <brahim.sliti@feesh.ch>"

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash \
  && apt-get install -y nodejs

USER jenkins

ENTRYPOINT ["setup-sshd"]
