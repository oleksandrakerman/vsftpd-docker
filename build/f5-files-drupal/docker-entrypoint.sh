#!/bin/bash
set -e

if [[ "$1" == apache2* ]] || [ "$1" == php-fpm ]; then
	# Wait for MySQL to come up
	echo Checking MySQL connectivity.
	i=0
	while ! mysqladmin ping -u f5_files -pf5_files -h mysql --silent; do
		if [ $i -ge 60 ]; then
			echo "MySQL waiting timeout."
			exit 1
		fi
		((i=i+1))
		sleep 1
	done

	# Load pre-cooked database dump (mysql).
	if [ -e dump.sql ]; then
		mysql -u f5_files -pf5_files -h mysql f5_files < dump.sql;
		echo MySQL imported.
                rm dump.sql
	fi

	# Wait for MySQL pam to come up
	echo Checking MySQL pam connectivity.
	i=0
	while ! mysqladmin ping -u vsftpd -pftpdpass -h mysql_pam --silent; do
		if [ $i -ge 60 ]; then
			echo "MySQL pam waiting timeout."
			exit 1
		fi
		((i=i+1))
		sleep 1
	done

	# Load pre-cooked database dump (mysql for pam).
	if [ -e dump.sql ]; then
		mysql -u vsftpd -pftpdpass -h mysql_pam vsftpd < vsftpd.sql;
		echo MySQL pam imported.
                rm vsftpd.sql
	fi

fi

exec "$@"
