#!/bin/bash

echo "$CLOUD9_USER:$CLOUD9_PASSWORD" | chpasswd

mkdir -p $CLOUD9_HOME
chown $CLOUD9_USER:$CLOUD9_GROUP $CLOUD9_HOME
su - $CLOUD9_USER -c "cp -n -r --preserve=mode /etc/skel/. $CLOUD9_HOME"

if [ $CLOUD9_GRANT_SUDO = "yes" ]; then
  echo "$CLOUD9_USER ALL=(ALL) ALL" >> /etc/sudoers.d/$CLOUD9_USER
elif [ $CLOUD9_GRANT_SUDO = "nopass" ]; then
  echo "$CLOUD9_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$CLOUD9_USER
fi

mkdir -p $CLOUD9_HOME/.ssh
echo "add RSA $CLOUD9_RSA"
echo $CLOUD9_RSA > $CLOUD9_HOME/.ssh/authorized_keys
chown -R $CLOUD9_USER:$CLOUD9_GROUP $CLOUD9_HOME/.ssh
chmod 700 $CLOUD9_HOME/.ssh
chmod 600 $CLOUD9_HOME/.ssh/authorized_keys

/usr/sbin/sshd -D
