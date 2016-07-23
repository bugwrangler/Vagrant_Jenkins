
# Please don't touch unless you know what you're doing! Jenkins box using Vagrant :)

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Ubuntu Image 

  config.vm.box = "ubuntu/trusty64"

  # Memory Allocation

  config.vm.network "forwarded_port", guest: 6060, host: 6060

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  config.vm.provision :shell, :privileged => true, :path => "provision.sh"
end