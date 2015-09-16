# OBI Build

This is an **experimental** repository for a revised OBI build system. It is based on [commit r4002](https://sourceforge.net/p/obi/code/4002/) to the OBI Subversion repository on SourceForge, with the main OWL file renamed to `edit.owl`, `external-byhand.owl` moved to `imports`, and some updates to import file names and IRIs.


## Use

Clone this repository and `cd` into it:

    git clone https://github.com/jamesaoverton/obi-build.git
    cd obi-build

Then open `edit.owl` in [Protégé](http://protege.stanford.edu). The directory structure and `catalog-v001.xml` file are important, so make sure that Protégé opens the `edit.owl` file in its proper context.


## Build

This project uses [GNU Make](http://www.gnu.org/software/make/) and standard Unix tools. If you're on a Unix or Linux system, you probably have all the requirements installed already. If you're on a Mac OS X system, you might be prompted to install [XCode](https://developer.apple.com/xcode/). If you're on Windows, then you should use [Vagrant](https://www.vagrantup.com) to run a virtual machine with a [Debian Linux](https://www.debian.org) operating system. (Even if you're using Linux or Mac OS X, Vagrant can be a good option.) The [`Vagrantfile`](Vagrantfile) will configure Vagrant for you.

Once Vagrant is installed, these commands will download a virtual machine image (about 500MB altogether), start the virtual machine, log in to it, and change to the special `/vagrant` directory that is linked to the project directory on your host operating system:

    > vagrant up
    > vagrant ssh
    $ cd /vagrant

Now you can run the build:

    make clean obi.owl

When you're done, log out and then either suspend (pause), stop, or destroy the virtual machine:

    $ exit
    > vagrant suspend
    > vagrant halt
    > vagrant destroy

You can update the software on the virtual machine with:

    vagrant provision
