# Vagrant Projects
Just some Vagrant builds I  as my sandbox. Feel free to copy or fork this stuff.

## Quickstart
1. [Install softwares](#Install-softwares)
1. [Create a VM using Vagrant](#Create-a-VM-using-Vagrant)
1. [Helpful commands to manage a VM using  Vagrant](#Manage-a-VM-using-Vagrant)

## Builds
* [Spotify Backstage IDP](backstage)

## Install softwares
1. [Download and install Vagrant](https://developer.hashicorp.com/vagrant/install?product_intent=vagrant). Note, this will require a system restart.
1. [Download and install VirtualBox](https://www.virtualbox.org/wiki/Downloads)
1. To verify the installation for the vagrant, execute the following vagrant command to see if it outputs the version <br/>
`
vagrant --version
`

## Create a VM using Vagrant
Create a directory to keep all vagrant-related files and create a VM project directory <br/>
```
mkdir backstage
cd backstage
```

Initialize the Vagrant configuration file </br>
```
vagrant init ubuntu/trusty64
```

Start the VM
```
vagrant up
```

## Manage a VM using  Vagrant
You can use Vagrant to manage the running virtual machine. Here are some useful Vagrant commands:

* **vagrant up:** Launches the virtual machine and provisions it according to the settings in the Vagrantfile. This command will simply connect to the virtual machine if it is already running.

* **vagrant halt:** Stops the virtual machine by delivering a shutdown signal to the guest operating system. This command is similar to shutting down a real computer.

* **vagrant reload:** Restarts the virtual machine and re-provisions it depending on any changes in the Vagrantfile.

* **vagrant ssh:** Connects to the virtual machine via SSH. This command is useful for accessing the command line interface of the virtual machine.

* **vagrant status:** Shows the current status of the virtual machine, including whether it's running, stopped, or suspended.

* **vagrant destroy:** Deletes the virtual machine and all associated resources. This command is useful for cleaning up your development environment.
