Vagrant.configure('2') do |config|

	config.vm.box = 'puppetlabs/centos-6.6-64-puppet'
  config.vm.box_url = 'https://atlas.hashicorp.com/puppetlabs/boxes/centos-6.6-64-puppet'

  if Vagrant.has_plugin?('landrush')
   config.landrush.enabled = true
   config.landrush.tld = 'vm'
  end

  config.vm.define 'modroster' do |modroster|

    config.vm.hostname = 'modroster.vm'

    #config.vm.network :private_network, type: 'static', ip: '10.1.1.3'
    config.vm.network :forwarded_port, guest: 80, host: 1080, auto_correct: true
    config.vm.network :forwarded_port, guest: 443, host: 10443, auto_correct: true

    config.vm.provision :shell, :path   => "install-puppet-modules.sh"
    config.vm.provision :shell, :inline => 'yum clean all'

    config.vm.provision :puppet do |puppet|
      puppet.options = '--parser future' # vhost iteration in site.pp
      puppet.manifests_path = 'puppet/manifests'
      puppet.manifest_file = ''
      puppet.hiera_config_path = 'puppet/hiera.yaml'
      puppet.module_path = ['puppet/modules/forge', 'puppet/modules/custom']
    end

    config.vm.provider :virtualbox do |v|
      v.name = 'modroster'
    end

  end

end 
