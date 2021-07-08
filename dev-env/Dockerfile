FROM buildpack-deps:buster AS base

# Setup base environment
RUN set -eux && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    acl \
    bison \
    fonts-powerline \
    fzf \
    gosu \
    hunspell \
    less \
    libbluetooth-dev \
    locales \
    man \
    powerline \
    ripgrep \
    sudo \
    tk-dev \
    tmux \
    tree \
    uuid-dev \
    vim-nox \
    watch \
    zip \
    zsh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen

ENV LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
RUN chsh -s $(which zsh) && echo 'export PATH=$HOME/bin:$HOME/.local/bin:$PATH' >> $HOME/.zshenv

# Install docker client
COPY --from=docker:20 /usr/local/bin/docker /usr/local/bin/

# Install neovim
RUN set -eux && \
    curl -sfLo /usr/local/nvim/nvim.appimage --create-dir https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && \
    chmod u+x /usr/local/nvim/nvim.appimage && \
    cd /usr/local/nvim && ./nvim.appimage --appimage-extract && \
    chmod -R a+rX /usr/local/nvim && \
    ln -s /usr/local/nvim/squashfs-root/AppRun /usr/local/bin/nvim

# Setup tmux
RUN set -eux && \
    echo 'unbind C-b' >> /etc/tmux.conf && \
    echo 'set-option -g prefix C-a' >> /etc/tmux.conf && \
    echo 'set-option -g default-terminal "screen-256color"' >> /etc/tmux.conf && \
    echo 'set-option -sa terminal-overrides ",$TERM:RGB"' >> /etc/tmux.conf && \
    echo 'set-option -sg escape-time 10' >> /etc/tmux.conf

# Setup ruby environment
RUN set -eux && \
    git clone https://github.com/rbenv/rbenv.git $HOME/.rbenv && \
    git clone https://github.com/rbenv/ruby-build.git $HOME/.rbenv/plugins/ruby-build && \
    cd $HOME/.rbenv && src/configure && make -C src && \
    echo 'export RBENV_ROOT=$HOME/.rbenv' >> $HOME/.zshenv && \
    echo 'export PATH=$RBENV_ROOT/bin:$PATH' >> $HOME/.zshenv && \
    echo 'eval "$(rbenv init - zsh)"' >> $HOME/.zshenv

# Setup python environment
RUN set -eux && \
    git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv && \
    git clone https://github.com/pyenv/pyenv-virtualenv.git $HOME/.pyenv/plugins/pyenv-virtualenv && \
    cd $HOME/.pyenv && src/configure && make -C src && \
    echo 'export PYENV_ROOT=$HOME/.pyenv' >> $HOME/.zshenv && \
    echo 'export PATH=$PYENV_ROOT/bin:$PATH' >> $HOME/.zshenv && \
    echo 'eval "$(pyenv init --path)"' >> $HOME/.zshenv && \
    echo 'eval "$(pyenv init -)"' >> $HOME/.zshenv && \
    echo 'eval "$(pyenv virtualenv-init -)"' >> $HOME/.zshenv && \
    echo 'export PYENV_VIRTUALENV_DISABLE_PROMPT=1' >> $HOME/.zshenv

# Setup rust environment
RUN curl --silent --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | zsh -s -- -y

# Setup nodejs environment
RUN set -eux && \
    git clone https://github.com/nvm-sh/nvm.git $HOME/.nvm && \
    cd $HOME/.nvm && git checkout v0.38.0 && \
    echo 'export NVM_DIR=$HOME/.nvm' >> $HOME/.zshenv && \
    echo 'source $NVM_DIR/nvm.sh' >> $HOME/.zshenv

RUN set -eux && curl -s "https://get.sdkman.io" | zsh && \
    echo 'export SDKMAN_DIR="$HOME/.sdkman"' >> $HOME/.zshenv && \
    echo '[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"' >> $HOME/.zshenv

# Setup oh-my-zsh
RUN set -eux && \
    git clone https://github.com/ohmyzsh/ohmyzsh.git $HOME/.oh-my-zsh && \
    cp $HOME/.oh-my-zsh/templates/zshrc.zsh-template $HOME/.zshrc

# Add default user dev
RUN set -eux && \
    sed -i 's/SHELL=\/bin\/sh$/SHELL=\/usr\/bin\/zsh/g' /etc/default/useradd && \
    cp -r $HOME/. /etc/skel && \
    useradd -s $(which zsh) -u 1000 -U -m dev && \
    echo "dev ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/dev && chmod 0440 /etc/sudoers.d/dev
WORKDIR /home/dev

# Setup gnupg
ENV GNUPGHOME=/home/gnupg
RUN set -eux && \
    mkdir $GNUPGHOME && \
    curl --silent https://github.com/web-flow.gpg | gpg --quiet --import && \
    chmod -R a+rwX $GNUPGHOME

COPY entrypoint.sh /usr/local/bin
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

FROM base AS lyang
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

ADD https://api.github.com/repos/lyang/my-dot-files/git/refs/heads/main /tmp/my-dot-files.json
RUN git clone https://github.com/lyang/my-dot-files.git

RUN ./my-dot-files/setup.sh

USER root
COPY cmd.sh /usr/local/bin
CMD ["/usr/local/bin/cmd.sh"]
