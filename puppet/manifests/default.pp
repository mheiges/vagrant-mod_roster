Package {
  allow_virtual => true,
}

class { '::firewall_impl': }

#exec { "reload_sysctl":
#  command => "/sbin/sysctl -e -p",
#  refreshonly => true;
#}
#
#augeas { 'net.ipv6.conf.all.disable_ipv6':
#  context => "/files/etc/sysctl.conf",
#  changes => ["set net.ipv6.conf.all.disable_ipv6 1"],
#  notify  => Exec["reload_sysctl"],
#}
#
#augeas { 'net.ipv6.conf.default.disable_ipv6':
#  context => "/files/etc/sysctl.conf",
#  changes => ["set net.ipv6.conf.default.disable_ipv6 1"],
#  require => Augeas['net.ipv6.conf.all.disable_ipv6'],
#  notify  => Exec["reload_sysctl"],
#}
