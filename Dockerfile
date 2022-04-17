FROM jenkins/ssh-agent
LABEL maintainer="SLITI Brahim <brahim.sliti@feesh.ch>"

RUN apt-get update && apt-get install -y curl

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash \
  && apt-get install -y nodejs

USER jenkins

ENTRYPOINT ["setup-sshd"]
