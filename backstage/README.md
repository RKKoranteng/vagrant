## Pre-req
Before you start the steps below, make sure you have [Vagrant and VirtualBox softwares installed](../README.md#install-softwares)

## Steps
Clone the repository: <br />
```
git clone https://github.com/RKKoranteng/vagrant.git
cd <REPO>/backstage
```

Start the Vagrant VM: <br />
```
vagrant up
```

SSH into the VM: <br />
```
vagrant ssh
```

Start Backstage: <br />
```
cd ~/backstage/my-backstage-app
yarn dev
```
