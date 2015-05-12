Vagrant.configure('2') do |config|
  config.vm.define 'mod_roster' do |mod_roster| end
	config.vm.hostname = 'mod_roster'
	config.vm.box = 'puppetlabs/centos-6.6-64-puppet'
  config.vm.box_url = 'https://atlas.hashicorp.com/puppetlabs/boxes/centos-6.6-64-puppet'

	config.vm.network :forwarded_port, guest: 80, host: 1080, auto_correct: true
	config.vm.network :forwarded_port, guest: 443, host: 10443, auto_correct: true

  config.vm.provision :shell, :path   => "install-puppet-modules.sh"
  config.vm.provision :shell, :inline => 'yum clean all'

	config.vm.provision :puppet do |puppet|
	  puppet.manifests_path = 'puppet/manifests'
	  puppet.manifest_file = ''
	  puppet.hiera_config_path = 'puppet/hiera.yaml'
    puppet.module_path = ['puppet/modules/forge', 'puppet/modules/custom']
  end
  
	config.vm.provider :virtualbox do |v|
		v.name = 'mod_roster'
	end

end
