#!/bin/bash

groupadd -f -g $VSCODE_GID $VSCODE_GROUP
useradd -d $VSCODE_HOME -u $VSCODE_UID -g $VSCODE_GID -s /bin/bash $VSCODE_USER
usermod -a -G dialout $VSCODE_USER

echo "$VSCODE_USER:$VSCODE_PASSWORD" | chpasswd

if [ $VSCODE_GRANT_SUDO = "yes" ]; then
  echo "$VSCODE_USER ALL=(ALL) ALL" >> /etc/sudoers.d/$VSCODE_USER
elif [ $VSCODE_GRANT_SUDO = "nopass" ]; then
  echo "$VSCODE_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$VSCODE_USER
fi

mkdir -p $VSCODE_HOME
chown $VSCODE_USER:$VSCODE_GROUP $VSCODE_HOME
su - $VSCODE_USER -c "cp -n -r --preserve=mode /etc/skel/. $VSCODE_HOME"

su - $VSCODE_USER -c "cd $VSCODE_HOME && PASSWORD=$VSCODE_PASSWORD code-server --host 0.0.0.0 --port=$VSCODE_PORT"

