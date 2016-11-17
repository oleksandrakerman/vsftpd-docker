Docker compose with 4 containers:

1. "web" - contains apache, php, grab site from local /var/www/html,
	Auto apload sites database named "dump.sql" from /var/www/html dir and auto rm it. 
        Auto apload pam database for vsftpd named "vsftpd.sql" from /var/www/html dir and auto rm it.

2. "mysql" - container with mysql for site.

3. "mysql_pam" - container with mysql for pam_mysql.

4. "vsftpd" - ftp server (based on centos 6.8)

