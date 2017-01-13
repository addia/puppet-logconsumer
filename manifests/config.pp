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
  $user             = $logconsumer::params::user,
  $group            = $logconsumer::params::group,
  $password         = $logconsumer::params::password,
  $passkey          = $logconsumer::params::passkey,
  $logstash_debug   = $logconsumer::params::logstash_debug,
  $config_dir       = $logconsumer::params::config_dir,
  $ssl_dir          = $logconsumer::params::ssl_dir,
  $rabbit_key       = $logconsumer::params::rabbit_key,
  $rabbit_crt       = $logconsumer::params::rabbit_crt,
  $rabbit_p12       = $logconsumer::params::rabbit_p12,
  $elastic_key      = $logconsumer::params::elastic_key,
  $elastic_crt      = $logconsumer::params::elastic_crt,
  $ssl_cacert_file  = $logconsumer::params::ssl_cacert_file,
  $keystore_dir     = $logconsumer::params::keystore_dir,
  $keystore_passwd  = $logconsumer::params::keystore_passwd,
  $service          = $logconsumer::params::service,
  $rabbit_address   = $logconsumer::params::rabbit_address,
  $elastic_address  = $logconsumer::params::elastic_address,
  $elastic_instance = $logconsumer::params::elastic_instance,
  $package_name     = $logconsumer::params::package_name

  ) {

  include logconsumer::params

  # notify { "Creating config files for: ${package_name}": }

  $config_input  = "${config_dir}/03_logstash-mq-input.conf"
  $config_filter = "${config_dir}/10_filter.conf"
  $config_output = "${config_dir}/32_logstash-elk-output.conf"

  file { $config_dir:
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0755'
    }

  file { $ssl_dir:
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0755'
    }

  file { $config_input:
    ensure  => file,
    owner   => $user,
    group   => $group,
    mode    => '0644',
    content => template('logconsumer/03_logstash-mq-input-conf.erb'),
    notify  => Service[$service]
    }

  file { $config_filter:
    ensure => file,
    owner  => $user,
    group  => $group,
    mode   => '0644',
    source => 'puppet:///modules/logconsumer/10_filter.conf',
    notify => Service[$service]
    }

  file { $config_output:
    ensure  => file,
    owner   => $user,
    group   => $group,
    mode    => '0644',
    content => template('logconsumer/32_logstash-elk-output-conf.erb'),
    notify  => Service[$service]
    }

  file { "${ssl_dir}/${rabbit_key}":
    ensure  => file,
    owner   => $user,
    group   => $group,
    mode    => '0644',
    content => hiera('elk_stack_rabbitmq_client_key')
    }

  file { "${ssl_dir}/${rabbit_crt}":
    ensure  => file,
    owner   => $user,
    group   => $group,
    mode    => '0644',
    content => hiera('elk_stack_rabbitmq_client_cert')
    }

  openssl::export::pkcs12 { 'rabbitmq-client':
    ensure   => 'present',
    basedir  => $ssl_dir,
    pkey     => "${ssl_dir}/${rabbit_key}",
    cert     => "${ssl_dir}/${rabbit_crt}",
    in_pass  => '',
    out_pass => '',
    }

  file { "${ssl_dir}/${elastic_key}":
    ensure  => file,
    owner   => $user,
    group   => $group,
    mode    => '0644',
    content => hiera('elk_stack_elastic_key')
    }

  file { "{${ssl_dir}/${elastic_crt}":
    ensure  => file,
    owner   => $user,
    group   => $group,
    mode    => '0644',
    content => hiera('elk_stack_elastic_cert')
    }

  java_ks {"eleastic_instance_${elastic_instance}_keystore_ca":
    ensure       => 'latest',
    certificate  => $ssl_cacert_file,
    target       => "${keystore_dir}/${elastic_instance}.ks",
    password     => $keystore_passwd,
    trustcacerts => true,
    }

  java_ks {"eleastic_instance_${elastic_instance}_keystore_node":
    ensure      => 'latest',
    certificate => "${ssl_dir}/${elastic_crt}",
    private_key => "${ssl_dir}/${elastic_key}",
    target      => "${keystore_dir}/${elastic_instance}.ks",
    password    => $keystore_passwd,
    }

  }


# vim: set ts=2 sw=2 et :
