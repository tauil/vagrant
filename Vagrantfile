# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "mysql" do |mysql|
    mysql.vm.box = "dev-box-mysql"

    mysql.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

    mysql.vm.provider :virtualbox do |vb|
      vb.name = 'dev-box-mysql'
      vb.customize ["modifyvm", :id, "--memory", "2048"]
      vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
    end

    mysql.vm.provision 'shell', path: 'dev-box-provision-files-mysql/guest_install_and_run.sh'
  end

  config.vm.define "xp" do |mysql|
    mysql.vm.box = "dev-box-xp"

    # In this post: https://github.com/mitchellh/vagrant/issues/7155#issuecomment-228568200
    # suggests to use https://github.com/chef/bento instead of use boxes under ubuntu namespace,
    # which are not Canonical official.
    mysql.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-16.04_chef-provisionerless.box"

    mysql.vm.provider :virtualbox do |vb|
      vb.name = 'dev-box-xenial-postgresql'
      vb.customize ["modifyvm", :id, "--memory", "2048"]
      vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
    end

    mysql.vm.provision 'shell', path: 'dev-box-provision-files-xp/guest_install_and_run.sh'
  end

  config.vm.define "postgres" do |postgres|
    postgres.vm.box = "dev-box-postgres"
    postgres.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
    postgres.vm.hostname = 'dev-box-postgres'

    postgres.vm.provider :virtualbox do |vb|
      vb.name = 'dev-box-postgres'
      vb.customize ["modifyvm", :id, "--memory", "5120"]
      vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
    end

    postgres.vm.provision 'shell', path: 'dev-box-provision-files/guest_install_and_run.sh'
  end

  if ARGV[0] == "ssh"
    config.ssh.username = 'tauil'
    #config.ssh.private_key_path = '~/.ssh/id_rsa.pub'
  end

  config.vm.network :forwarded_port, guest: 3000, host: 3000 # rails
  config.vm.network :forwarded_port, guest: 3001, host: 3001 # rails
  config.vm.network :forwarded_port, guest: 4000, host: 4000 # jekyll
  config.vm.network :forwarded_port, guest: 4567, host: 4567 # sinatra
  config.vm.network :forwarded_port, guest: 6379, host: 6379 # redis
  config.vm.network :forwarded_port, guest: 4200, host: 4200 # ember
  config.vm.network :forwarded_port, guest: 49152, host: 49152 # live reload
  config.vm.network :forwarded_port, guest: 35729, host: 35729 # ember stuff
  config.vm.network :forwarded_port, guest: 3306, host: 3306 # mysql
  config.vm.network :forwarded_port, guest: 9001, host: 9001 # angular

  # https://github.com/mhallin/vagrant-notify-forwarder
  config.notify_forwarder.port = 9001 # Or your port number

  config.vm.network :private_network, ip: "192.168.33.10"
  config.ssh.forward_agent = true
  config.vm.synced_folder ".", "/projects", nfs: !RUBY_PLATFORM.downcase.include?("w32") # false no windows, true no resto
end
