node 'apache' {


  class { '::apache': }

  apache::vhost { 'first.example.com':
    port    => '80',
    docroot => '/var/www/first',
  }
  
  exec { 'create-default-index':
    command => 'echo Hello World > /var/www/html/index.html',
    path    => "/bin",
    require => Class['apache'],
  }

  firewall { '100 allow http':
    chain  => 'INPUT',
    state  => ['NEW'],
    dport  => '80',
    proto  => 'tcp',
    action => 'accept',
  }

  firewall { '100 allow https':
    chain  => 'INPUT',
    state  => ['NEW'],
    dport  => '443',
    proto  => 'tcp',
    action => 'accept',
  }

}