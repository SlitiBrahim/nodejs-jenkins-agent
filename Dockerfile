FROM ubuntu:20.04
MAINTAINER SLITI Brahim <brahim.sliti@feesh.ch>

RUN apt-get update && apt-get dist-upgrade -y && rm -rf /var/lib/apt/lists/*
RUN apt-get update && DEBIAN_FRONTEND="noninteractive" apt-get install -y \
    git \
    apt-transport-https \
    curl \
    init \
    openssh-server openssh-client \
    gconf-service \
    libasound2 \ 
    libatk1.0-0 \ 
    libc6 \ 
    libcairo2 \ 
    libcups2 \ 
    libdbus-1-3 \ 
    libexpat1 \ 
    libfontconfig1 \ 
    libgcc1 \ 
    libgconf-2-4 \ 
    libgdk-pixbuf2.0-0 \ 
    libglib2.0-0 \ 
    libgtk-3-0 \ 
    libnspr4 \ 
    libpango-1.0-0 \ 
    libpangocairo-1.0-0 \ 
    libstdc++6 \ 
    libx11-6 \ 
    libx11-xcb1 \ 
    libxcb1 \ 
    libxcomposite1 \ 
    libxcursor1 \ 
    libxdamage1 \ 
    libxext6 \ 
    libxfixes3 \ 
    libxi6 \ 
    libxrandr2 \ 
    libxrender1 \ 
    libxss1 \ 
    libxtst6 \ 
    ca-certificates \ 
    fonts-liberation \ 
    libappindicator1 \ 
    libnss3 \ 
    lsb-release \ 
    xdg-utils \ 
    wget \ 
    git \ 
    libgbm-dev
 && rm -rf /var/lib/apt/lists/*

# Install Java
RUN apt-get update && apt-get install -y openjdk-8-jdk && rm -rf /var/lib/apt/lists/*

# Add Jenkins user and group
RUN groupadd -g 10000 jenkins \
    && useradd -d $HOME -u 10000 -g jenkins jenkins

# Install jenkins jnlp
RUN curl --create-dirs -sSLo /usr/share/jenkins/slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/4.9/remoting-4.9.jar \
    && chmod 755 /usr/share/jenkins \
    && chmod 644 /usr/share/jenkins/slave.jar

COPY jenkins-slave /usr/local/bin/jenkins-slave
RUN chmod 755 /usr/local/bin/jenkins-slave && chown jenkins:jenkins /usr/local/bin/jenkins-slave

RUN mkdir -p /home/jenkins/.jenkins \
    && mkdir -p /home/jenkins/agent \
    && chown -R jenkins:jenkins /home/jenkins

VOLUME /home/jenkins/.jenkins
VOLUME /home/jenkins/agent

WORKDIR /home/jenkins

ENTRYPOINT ["/usr/local/bin/jenkins-slave"]
