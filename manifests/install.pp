# == Class log-consumer::install
# ==============================
#
#
# Description of the Class:
#
#   This class is meant to be called from init.pp only.
#
#
# ===========================
#
class log-consumer::install (
  $ensure             = $log-consumer::ensure,
  $package_name       = $log-consumer::package_name
  ) inherits log-consumer::params {

  include log-consumer::repo

  notify { "Installing package: ${package_name}": }

  package { ['java-1.8.0-openjdk', 'java-1.8.0-openjdk-devel'] :
    ensure            => present,
  }
  package { $package_name:
    ensure            => $ensure
  }
}


# vim: set ts=2 sw=2 et :
