# == Class: log-consumer
# ===========================
#
#
# Description of the Class:
#
#   Install and configure the logstash service pulling messages from RabbitMQ Queue into ELK
#
#
# Document all Parameters:
#
#   Explanation of what this parameter affects and what it defaults to.
#     ensure             = package install status
#     status             = default service state
#     user               = run as user
#     group              = run as group
#     config_dir         = prospector plug-in directory path
#     ssl_dir            = certificate path
#     rabbit_key         = rabbit key
#     rabbit_crt         = rabbit cert
#     elastic_key        = elastic key
#     elastic_crt        = elastic cert
#     service            = systemd service file name
#     systemd_file       = systemd service file including full path
#     rabbit_address     = rabbitmq server/cluster address IP or DNS
#     elastic_address    = elastic server/cluster address IP or DNS
#     package_name       = the package name to install and configure
#     repo_version       = the repo version
#
#
# ===========================
#
#
# == Parameters
# -------------
#
#
# == Authors
# ----------
#
# Author: Addi <addi.abel@gmail.com>
#
#
# == Copyright
# ------------
#
# Copyright:  ©  2016  LR / Addi.
#
#
class log-consumer (
  $ensure             = $log-consumer::params::ensure,
  $status             = $log-consumer::params::status,
  $user               = $log-consumer::params::user,
  $group              = $log-consumer::params::group,
  $config_dir         = $log-consumer::params::config_dir,
  $ssl_dir            = $log-consumer::params::ssl_dir,
  $rabbit_key         = $log-receiver::params::rabbit_key,
  $rabbit_crt         = $log-receiver::params::rabbit_crt,
  $elastic_key        = $log-receiver::params::elastic_key,
  $elastic_crt        = $log-receiver::params::elastic_crt,
  $service            = $log-consumer::params::service,
  $systemd_file       = $log-consumer::params::systemd_file,
  $rabbit_address     = $log-consumer::params::rabbit_address,
  $elastic_address    = $log-consumer::params::elastic_address,
  $package_name       = $log-consumer::params::package_name,
  $repo_version       = $log-consumer::params::repo_version
) inherits log-consumer::params {

    notify { "Installing and configuring ${logstash_pkg}": }

    anchor { 'log-consumer::begin': } ->
    class { '::log-consumer::accounts': } ->
    class { '::log-consumer::install': } ->
    class { '::log-consumer::config': } ->
    class { '::log-consumer::service': } ->
    anchor { 'log-consumer::end': }

}


# vim: set ts=2 sw=2 et :
