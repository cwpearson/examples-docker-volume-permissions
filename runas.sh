#!/bin/bash
echo "running with $@"
echo "setting user as $USER_DIR"
if [ -z "$USER_DIR" ]; then
  if [ -e /etc/user_dir ]; then
    export USER_DIR=`head -n 1 /etc/user_dir`
  fi
fi
if [ -n "$USER_DIR" ]; then
  if [ ! -d "$USER_DIR" ]; then
    echo "Please mount $USER_DIR before running this script"
    exit 1
  fi
  . /setuser.sh $USER_DIR
fi
if [ -n "$USER_DIR" ]; then
  cd $USER_DIR
fi
if [ -e /etc/user_script ]; then
  . /etc/user_script
fi
if [ $CURRENT_UID = $DEST_UID ]; then
  "$@"
else
  su $DEST_UID -p -c "$@"
fi
