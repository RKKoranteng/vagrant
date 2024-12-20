## Pre-req
Before you start the steps below, make sure you have [Vagrant and VirtualBox softwares installed](../README.md#quickstart)

## Steps
1 - Clone the repository: <br />
```
git clone https://github.com/RKKoranteng/vagrant.git
cd <REPO>/backstage
```

2 - Start the Vagrant VM: <br />
```
vagrant up
```

3 - Restart the VM for GUI settings to take effect: <br />
```
vagrant reload
```

4 - SSH into the VM: <br />
```
vagrant ssh
```

5 - Start Backstage: <br />
```
cd ~/backstage/my-backstage-app
yarn dev
```

6 - Login to VM GUI > Open Firefox > Navigiate to http://localhost:3000/
> VM credentials: 'vagrant/vagrant'


