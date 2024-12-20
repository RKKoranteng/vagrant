# By default, MySQL 8.0 is included in the Rocky Linux AppStream repository.
# You can verify the available MySQL versions with the following command:
sudo dnf module list mysql

# Enable the MySQL repository with the following command:
sudo dnf -y module enable mysql:8.0


# Install mysql-server package and dependencies
sudo dnf install -y mysql-server

# Install MySQL 8.0
sudo dnf install @mysql -y
mysql --version

# Start the MySQL service and systemctl enable  the MySQL 
# service to start at system reboot
sudo systemctl start mysqld
sudo systemctl enable mysqld
sudo systemctl status mysqld