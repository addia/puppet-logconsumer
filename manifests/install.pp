# == Class logconsumer::install
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
class logconsumer::install (
  $ensure             = $logconsumer::ensure,
  $package_name       = $logconsumer::package_name,
  $package_vers       = $logreceiver::params::package_vers
) inherits logconsumer::params {

  include logconsumer::repo

  notify { "Installing package: ${package_name}": }

  package { ['java-1.8.0-openjdk', 'java-1.8.0-openjdk-devel'] :
    ensure            => present,
    }

  package { $package_name:
    ensure            => $package_vers,
    }
  }


# vim: set ts=2 sw=2 et :
