Vagrant.configure("2") do |config|
  config.vm.box = "archlinux/archlinux"

  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.cpus = 4
    vb.memory = "4096"
  end

  config.disksize.size = "30GB"

  config.vm.provision "shell", :path => "bootstrap.sh"
  config.vm.provision "shell", :path => "bootstrap.user.sh", privileged: false
end
