# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.
  config.vm.box = "debian/jessie64"
  config.vm.box_version = "8.2.0"

  # Share folder using NFS: https://stefanwrobel.com/how-to-make-vagrant-performance-not-suck
  config.vm.network :private_network, ip: '192.168.50.50'
  config.vm.synced_folder '.', '/vagrant', nfs: true

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # TODO: Using insecure `curl -k` because of certificate problem with BBOP.
  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
    sudo apt-get install -y openjdk-7-jre-headless
    echo 'Fetching ROBOT'
    sudo curl -ksL -o /usr/local/bin/robot.jar "https://build.berkeleybop.org/job/robot/lastSuccessfulBuild/artifact/bin/robot.jar"
    sudo curl -ksL -o /usr/local/bin/robot "https://build.berkeleybop.org/job/robot/lastSuccessfulBuild/artifact/bin/robot"
    sudo chmod +x /usr/local/bin/robot
  SHELL
end
