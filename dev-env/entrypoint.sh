#!/bin/zsh

if [ -z $SSH_AUTH_SOCK ]; then
  echo "No mounted ssh sock"
elif [ -S $SSH_AUTH_SOCK ]; then
  gid=$(stat -c "%g" $SSH_AUTH_SOCK)
  groupadd -g $gid ssh
  usermod -a -G $gid dev
fi

if [ -S /var/run/docker.sock ]; then
  gid=$(stat -c "%g" /var/run/docker.sock)
  echo "docker $gid"
  groupadd -g $gid docker
  usermod -a -G $gid dev
else
  echo "No mounted docker sock"
fi

exec gosu dev /bin/zsh -lc ${@:-tmux}
