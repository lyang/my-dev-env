FROM linyang1218/dev-env:latest
RUN \
  apt-get update && \
  apt-get install -y --no-install-recommends \
  libcanberra-gtk-module \
  libcanberra-gtk0 \
  libfontconfig1 \
  libfreetype6-dev \
  libgtk2.0-0 \
  libxext-dev \
  libxrender-dev \
  libxslt1.1 \
  libxtst-dev \
  libxxf86vm1 && \
  rm -rf /var/lib/apt/lists/*

ENV IDEA_BUILD=2021.1.1
RUN \
  curl -fSL https://download.jetbrains.com/idea/ideaIC-$IDEA_BUILD.tar.gz --create-dir -o /usr/local/idea/installer.tgz && \
  tar --strip-components=1 -xzf /usr/local/idea/installer.tgz -C /usr/local/idea && \
  chmod -R a+rX /usr/local/idea && \
  ln -fs /usr/local/idea/bin/idea.sh /usr/local/bin/idea && \
  rm /usr/local/idea/installer.tgz

USER dev

ADD https://api.github.com/repos/lyang/Dockerfiles/git/refs/heads/main /tmp/dockerfiles.json
RUN git clone https://github.com/lyang/Dockerfiles.git

ADD https://api.github.com/repos/lyang/my-dot-files/git/refs/heads/main /tmp/my-dot-files.json
RUN git clone https://github.com/lyang/my-dot-files.git

RUN ./my-dot-files/setup.sh

USER root
COPY cmd.sh /usr/local/bin
CMD ["/usr/local/bin/cmd.sh"]
