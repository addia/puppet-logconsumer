# == Class log-consumer::params
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
class log-consumer::params {

  $ensure             = 'present'
  $status             = 'enabled'
  $user               = 'logstash'
  $group              = 'logstash'
  $config_dir         = '/etc/logstash/conf.d'
  $ssl_dir            = '/etc/logstash/ssl'
  $rabbit_key         = 'rabbitmq-client.key'
  $rabbit_crt         = 'rabbitmq-client.crt'
  $elastic_key        = 'elastic-client.key'
  $elastic_crt        = 'elastic-client.crt'
  $service            = 'log-consumer.service'
  $systemd_file       = "/usr/lib/systemd/system/${service}"
  $rabbit_address     = hiera('elk_stack_rabbitmq_address')
  $elastic_address    = hiera('elk_stack_elastic_address')
  $package_name       = 'logstash'
  $repo_version       = '2.2'

}


# vim: set ts=2 sw=2 et :
