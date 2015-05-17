
class { '::apache': }
class { '::epel': }

# requires puppet apply option "--parser future"
$vhosts = ['one', 'two', 'three']
each($vhosts) |$host| {

  apache::vhost { "${host}.example.com":
    port       => '80',
    docroot    => "/var/www/${host}",
  }

  exec { "create-${host}-index":
    command => "echo Hello from ${host} > /var/www/${host}/index.html",
    path    => '/bin',
    creates => "/var/www/${host}/index.html",
    require => Class['apache'],
  }

  host { "${host}.example.com":
      ip => '127.0.0.1',
  }

}

exec { 'create-default-index':
  command => 'echo Hello World > /var/www/html/index.html',
  path    => '/bin',
  creates => '/var/www/html/index.html',
  require => Class['apache'],
}

package { 'librabbitmq':
  ensure  => installed,
  require => Class['::epel'],
}

package { 'perl-ExtUtils-MakeMaker':
  ensure => installed,
}

exec { 'fetch-net-rabbitmq':
  command => 'curl -OLs http://search.cpan.org/CPAN/authors/id/J/JE/JESUS/Net--RabbitMQ-0.2.8.tar.gz',
  path    => ['/bin', '/usr/bin'],
  cwd     => '/tmp',
  creates => '/tmp/Net--RabbitMQ-0.2.8.tar.gz',
  require => Package['librabbitmq'],
}

exec { 'untar-net-rabbitmq':
  command => 'tar --exclude=\'._*\' -zxf Net--RabbitMQ-0.2.8.tar.gz',
  path    => ['/bin', '/usr/bin'],
  cwd     => '/tmp',
  creates => '/tmp/Net--RabbitMQ-0.2.8',
  require => Exec['fetch-net-rabbitmq'],
}

exec { 'net-rabbitmq-makefile':
  command => 'perl Makefile.PL',
  path    => ['/bin', '/usr/bin'],
  cwd     => '/tmp/Net--RabbitMQ-0.2.8',
  creates => '/tmp/Net--RabbitMQ-0.2.8/Makefile',
  require => [Package['perl-ExtUtils-MakeMaker'], Exec['untar-net-rabbitmq']],
}

exec { 'net-rabbitmq-install':
  command => 'make install',
  path    => ['/bin', '/usr/bin'],
  cwd     => '/tmp/Net--RabbitMQ-0.2.8',
  creates => '/usr/local/lib64/perl5/Net/RabbitMQ.pm',
  require => Exec['net-rabbitmq-makefile'],
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

