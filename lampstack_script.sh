#!/bin/bash
apt update
apt install apache2 -y
ufw app list
ufw allow in "Apache"
ufw status
systemctl status apache2
apt install mysql-server
mysql_secure_installation -yyyy
apt install php libapache2-mod-php php-mysql -y
php -v
rm /var/www/html/index.html
touch /var/www/html/index.html
cat > /var/www/html/index.html << EOF
<html>
  <head>
    <title>your_domain website</title>
  </head>
  <body>
    <h1>Hello Arun Abi!</h1>

    <p>This is the landing page of Arun Abi <strong>your_domain</strong>.</p>
  </body>
</html>
EOF
rm /etc/apache2/mods-enabled/dir.conf
touch /etc/apache2/mods-enabled/dir.conf
cat > /etc/apache2/mods-enabled/dir.conf << EOF
<IfModule mod_dir.c>
        DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm
</IfModule>
EOF
systemctl reload apache2
mysql -Bse "CREATE DATABASE example_database;CREATE USER 'example_user'@'%' IDENTIFIED WITH mysql_native_password BY 'Love_143';GRANT ALL ON example_database.* TO 'example_user'@'%';"
mysql -u example_user -pLove_143 -Bse "SHOW DATABASES"
mysql -Bse "CREATE TABLE example_database.todo_list (item_id INT AUTO_INCREMENT,content VARCHAR(255),PRIMARY KEY(item_id));"
mysql -Bse "INSERT INTO example_database.todo_list (content) VALUES ('I Love You Kelavi');"
mysql -Bse "INSERT INTO example_database.todo_list (content) VALUES ('I Love You Thiruttu Poona');"
mysql -Bse "INSERT INTO example_database.todo_list (content) VALUES ('I Love You Pondatti');"
mysql -Bse "INSERT INTO example_database.todo_list (content) VALUES ('I Love You Teena');"
mysql -Bse "SELECT * FROM example_database.todo_list;"
rm /var/www/html/todo_list.php
touch /var/www/html/todo_list.php
cat > /var/www/html/todo_list.php << EOF
<?php
\$user = "example_user";
\$password = "Love_143";
\$database = "example_database";
\$table = "todo_list";

try {
  \$db = new PDO("mysql:host=localhost;dbname=\$database", \$user, \$password);
  echo "<h2>TODO</h2><ol>";
  foreach(\$db->query("SELECT content FROM \$table") as \$row) {
    echo "<li>" . \$row['content'] . "</li>";
  }
  echo "</ol>";
} catch (PDOException \$e) {
    print "Error!: " . \$e->getMessage() . "<br/>";
    die();
}
EOF
systemctl reload apache2
