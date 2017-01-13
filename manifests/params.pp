# == Class logconsumer::params
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
class logconsumer::params {

  $user             = 'logstash'
  $group            = 'logstash'
  $password         = hiera('elk_stack_logstash_passwd')
  $passkey          = hiera('elk_stack_logstash_key')
  $logstash_debug   = hiera('elk_stack_logstash_debug')
  $config_dir       = '/etc/logstash/conf.d'
  $ssl_dir          = '/etc/logstash/ssl'
  $rabbit_key       = 'rabbitmq-client.key'
  $rabbit_crt       = 'rabbitmq-client.crt'
  $rabbit_p12       = 'rabbitmq-client.p12'
  $elastic_key      = 'elastic.key'
  $elastic_crt      = 'elastic.crt'
  $ssl_cacert_file  = '/etc/pki/ca-trust/source/anchors/elk_ca_cert.crt'
  $keystore_dir     = '/etc/logstash/ssl'
  $keystore_passwd  = 'keystore_pass'
  $service          = 'logconsumer.service'
  $systemd_file     = "/usr/lib/systemd/system/${service}"
  $rabbit_address   = hiera('elk_stack_rabbitmq_address')
  $elastic_address  = hiera('elk_stack_elastic_address')
  $elastic_instance = hiera('elk_stack_elastic_instance')
  $package_name     = 'logstash'
  $package_vers     = '2.3.4-1'
  $repo_version     = '2.3'

}


# vim: set ts=2 sw=2 et :
