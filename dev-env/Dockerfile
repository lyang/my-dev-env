FROM linyang1218/dev-env:latest
USER dev

ADD https://api.github.com/repos/lyang/Dockerfiles/git/refs/heads/main /tmp/dockerfiles.json
RUN git clone https://github.com/lyang/Dockerfiles.git

ADD https://api.github.com/repos/lyang/my-dot-files/git/refs/heads/main /tmp/my-dot-files.json
RUN git clone https://github.com/lyang/my-dot-files.git

RUN ./my-dot-files/setup.sh

USER root
COPY cmd.sh /usr/local/bin
CMD ["/usr/local/bin/cmd.sh"]
