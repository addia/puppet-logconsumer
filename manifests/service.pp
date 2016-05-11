# == Class log-consumer::service
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
class log-consumer::service (
  $systemd_file       = $log-consumer::params::systemd_file,
  $service            = $log-consumer::params::service,
  $package_name       = $log-consumer::params::package_name

  ) inherits log-consumer::params {

  notify { "Configuring service: ${service}": }
  
  file { $systemd_file:
    ensure            => file,
    owner             => 'root',
    group             => 'root',
    mode              => '0644',
    content           => template("${service}.erb"),
    notify            => Service[$service]
  }

  service { $service:
    ensure            => running,
    enable            => true,
    hasrestart        => true,
    hasstatus         => true,
    require           => File[$systemd_file]
  }

}


# vim: set ts=2 sw=2 et :
