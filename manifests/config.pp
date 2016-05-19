# == Class logconsumer::config
# =============================
#
#
# Description of the Class:
#
#   This class is meant to be called from init.pp only.
#
#
# ===========================
#
class logconsumer::config (
  $user               = $logconsumer::params::user,
  $group              = $logconsumer::params::group,
  $service            = $logconsumer::params::service,
  $rabbit_address     = $logconsumer::params::rabbit_address,
  $ssl_dir            = $logconsumer::params::ssl_dir,
  $rabbit_key         = $logconsumer::params::rabbit_key,
  $rabbit_crt         = $logconsumer::params::rabbit_crt,
  $elastic_key        = $logconsumer::params::elastic_key,
  $elastic_crt        = $logconsumer::params::elastic_crt,
  $config_dir         = $logconsumer::params::config_dir,
  $package_name       = $logconsumer::params::package_name

  ) inherits logconsumer::params {

  notify { "Creating config files for: ${package_name}": }

  $config_input       = "$config_dir/03_logstash-mq-input.conf"
  $config_output      = "$config_dir/32_logstash-elk-output.conf"


  file { $config_dir:
    ensure            => directory,
    owner             => $user,
    group             => $group,
    mode              => '0755'
  }

  file { $ssl_dir:
    ensure            => directory,
    owner             => $user,
    group             => $group,
    mode              => '0755'
  }

  file { "$ssl_dir/$rabbit_key":
    ensure            => file,
    owner             => $user,
    group             => $group,
    mode              => '0644',
    content           => hiera('elk_stack_rabbitmq_client_key')
  }

  file { "$ssl_dir/$rabbit_crt":
    ensure            => file,
    owner             => $user,
    group             => $group,
    mode              => '0644',
    content           => hiera('elk_stack_rabbitmq_client_cert')
  }

  file { "$ssl_dir/$elastic_key":
    ensure            => file,
    owner             => $user,
    group             => $group,
    mode              => '0644',
    content           => hiera('elk_stack_elastic_key')
  }

  file { "$ssl_dir/$elastic_crt":
    ensure            => file,
    owner             => $user,
    group             => $group,
    mode              => '0644',
    content           => hiera('elk_stack_elastic_cert')
  }

  file { $config_input: 
    ensure            => file,
    owner             => $user,
    group             => $group,
    mode              => '0644',
    content           => template('logconsumer/03_logstash-mq-input-conf.erb'),
    notify            => Service[$service]
  }

  file { $config_output: 
    ensure            => file,
    owner             => $user,
    group             => $group,
    mode              => '0644',
    content           => template('logconsumer/32_logstash-elk-output-conf.erb'),
    notify            => Service[$service]
  }

}


# vim: set ts=2 sw=2 et :
