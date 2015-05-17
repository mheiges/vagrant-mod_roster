

The VM will use the `vagrant-hostmanager` plugin if installed.

    vagrant plugin install vagrant-hostmanager

#### Puppet

The vhosts iteration in site.pp uses experimental Puppet syntax, so requires the '`--parser future`' option.

Puppet manifests are applied during `vagrant provision`. To manually apply manifests on the VM, run:

    sudo puppet apply --parser future --hiera_config=/vagrant/puppet/hiera.yaml --modulepath=/vagrant/puppet/modules/forge:/vagrant/puppet/modules/custom  /vagrant/puppet/manifests/ 
