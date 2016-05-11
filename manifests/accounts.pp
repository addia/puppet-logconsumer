# == Class log-consumer::accounts
# ===============================
#
#
# Description of the Class:
#
#   This class is meant to be called from init.pp only.
#
#
# ===========================
#
class log-consumer::accounts (
  $user               = $log-consumer::params::user,
  $group              = $log-consumer::params::group,
  $package_name       = $log-consumer::params::package_name

  ) inherits log-consumer::params {

  notify { "Creating accounts for: ${package_name}": }

  group {  $group:
    ensure     => present,
    gid        => 252
  }

  user { $user: 
    ensure     => present,
    home       => '/var/lib/logstash',
    shell      => '/bin/bash',
    uid        => '252',
    gid        => '252',
    password   => '!',
    managehome => true,
  }

}


# vim: set ts=2 sw=2 et :
