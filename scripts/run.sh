#!/bin/sh

if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

if [ -d /var/lib/mysql/mysql ]; then
	echo "MySQL directory already present, skipping creation"
else
	echo "MySQL data directory not found, creating initial DBs"

	chown -R mysql:mysql /var/lib/mysql

	mysql_install_db --user=mysql > /dev/null

    # postinstalation config
    TMP_SQL=`mktemp`
    if [ ! -f "$TMP_SQL" ]; then
        return 1
    fi

    echo "DROP DATABASE test;" > $TMP_SQL

    DATABASE_ADMIN=${DATABASE_ADMIN:-""}
    ADMIN_PSWD=${ADMIN_PSWD:-""}

    if [ "$DATABASE_ADMIN" != "" ] && [ "$ADMIN_PSWD" != "" ]; then
        echo "Create admin user"

        echo "USE mysql;" >> $TMP_SQL
        echo "FLUSH PRIVILEGES;" >> $TMP_SQL
	    echo "GRANT ALL ON *.* to '$DATABASE_ADMIN'@'%' IDENTIFIED BY '$ADMIN_PSWD';" >> $TMP_SQL
	    echo "UPDATE mysql.user SET plugin = 'mysql_native_password' WHERE user = '$DATABASE_ADMIN';" >> $TMP_SQL
	    echo "FLUSH PRIVILEGES;" >> $TMP_SQL

    fi
fi
    echo "Update configuration"
	/usr/bin/mysqld --user=mysql --bootstrap --verbose=0 < $TMP_SQL
    rm -f $TMP_SQL

exec /usr/bin/mysqld --user=mysql --console