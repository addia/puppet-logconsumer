# == Class logconsumer::service
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
class logconsumer::service (
  $systemd_file       = $logconsumer::params::systemd_file,
  $service            = $logconsumer::params::service,
  $package_name       = $logconsumer::params::package_name

) inherits logconsumer::params {

  notify { "Configuring service: ${service}": }
  
  file { $systemd_file:
    ensure            => file,
    owner             => 'root',
    group             => 'root',
    mode              => '0644',
    content           => template('logconsumer/logconsumer_service.erb'),
    notify            => Service[$service]
    }

  service { $service:
    ensure            => running,
    enable            => true,
    hasrestart        => true,
    hasstatus         => true,
    require           => File[$systemd_file]
    }

  service { 'logstash.service':
    ensure            => stopped,
    enable            => false
    }

  }


# vim: set ts=2 sw=2 et :
