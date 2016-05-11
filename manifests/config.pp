# == Class log-consumer::config
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
class log-consumer::config (
  $user               = $log-consumer::params::user,
  $group              = $log-consumer::params::group,
  $service            = $log-consumer::params::service,
  $rabbit_address     = $log-consumer::params::rabbit_address,
  $ssl_dir            = $log-consumer::params::ssl_dir,
  $rabbit_key         = $log-receiver::params::rabbit_key,
  $rabbit_crt         = $log-receiver::params::rabbit_crt,
  $elastic_key        = $log-receiver::params::elastic_key,
  $elastic_crt        = $log-receiver::params::elastic_crt,
  $config_dir         = $log-consumer::params::config_dir,
  $package_name       = $log-consumer::params::package_name

  ) inherits log-consumer::params {

  notify { "Creating config files for: ${package_name}": }

  $config_input       = "$config_dir/03_logstash-mq-input.conf"
  $config_output      = "$config_dir/32_logstash-elk-output.conf"
  $rabbitmq_cert      = "$ssl_dir/$rabbit_cert"
  $rabbitmq_key       = "$ssl_dir/$rabbit_key"
  $elastic_cert       = "$ssl_dir/$elastic_cert"
  $elastic_key        = "$ssl_dir/$elastic_key"


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
    content           => template('log-consumer/03_logstash-mq-input-conf.erb'),
    notify            => Service[$service]
  }

  file { $config_output: 
    ensure            => file,
    owner             => $user,
    group             => $group,
    mode              => '0644',
    content           => template('log-consumer/32_logstash-elk-output-conf.erb'),
    notify            => Service[$service]
  }

}


# vim: set ts=2 sw=2 et :
