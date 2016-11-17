#!/bin/sh

DIR=/home/vsftpd/users
mkdir -p $DIR/$PAM_USER
chown -R vsftpd:users $DIR/$PAM_USER

