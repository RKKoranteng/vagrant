## Pre-req
Before you start the steps below, make sure you have [Vagrant and VirtualBox softwares installed](../README.md#quickstart)

## Steps
1 - Clone the repository: <br />
```
git clone https://github.com/RKKoranteng/mysql.git
cd <REPO>/rel8
```

2 - Start the Vagrant VM: <br />
```
vagrant up
```

3 - SSH into the VM: <br />
```
vagrant ssh
```

5 - By default, MySQL is not secured and the root password is not set. You can secure it by running the following command: <br />
```
mysql_secure_installation
```

6 - After securing the MySQL, you can connect to the MySQL shell using the following command: `mysql -u root -p `


