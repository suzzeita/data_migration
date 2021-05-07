#!/bin/bash 
username=root
password=9860979729
hostname=localhost

echo "Enter the name of database you want to use"
read database_name

echo "Enter the table name"
read table_name

#Check if input database exists
mysql -u root -e "SHOW DATABASES;" | grep "$database_name"
if [ $? -eq 0 ]; then
    echo "Database exist."
else {
    echo "Database does not exist."
	exit 1
}
fi

#Check if input table exists
if [ $(mysql -u root –p9860979729 -se "select count(*) from information_schema.tables where table_schema='$database_name' and table_name='$table_name';") -eq 1 ];
then
	echo "Table exists"
else {
	echo "Table doesn't exist"
}
fi

#Generate .csv file from given table and database
mysql -u root –p9860979729 –e "use $database_name;
select * into outfile '/var/lib/mysql-files/sql.csv'
fields terminated by ''
optionally enclosed by ''
lines terminated by ''
from $table_name;"


#Mail generated .csv file to users configured in a file
sudo mailx -s "email message" -a /var/lib/mysql-files/sql.csv `cat/home/Desktop/email

