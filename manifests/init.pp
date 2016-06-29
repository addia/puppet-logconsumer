# == Class: logconsumer
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
#     password           = logstash password
#     passkey            = logstash keypass
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
class logconsumer (
  $ensure             = $logconsumer::params::ensure,
  $status             = $logconsumer::params::status,
  $user               = $logconsumer::params::user,
  $group              = $logconsumer::params::group,
  $password           = $logreceiver::params::password,
  $passkey            = $logreceiver::params::passkey,
  $config_dir         = $logconsumer::params::config_dir,
  $ssl_dir            = $logconsumer::params::ssl_dir,
  $rabbit_key         = $logconsumer::params::rabbit_key,
  $rabbit_crt         = $logconsumer::params::rabbit_crt,
  $elastic_key        = $logconsumer::params::elastic_key,
  $elastic_crt        = $logconsumer::params::elastic_crt,
  $service            = $logconsumer::params::service,
  $systemd_file       = $logconsumer::params::systemd_file,
  $rabbit_address     = $logconsumer::params::rabbit_address,
  $elastic_address    = $logconsumer::params::elastic_address,
  $package_name       = $logconsumer::params::package_name,
  $repo_version       = $logconsumer::params::repo_version
) inherits logconsumer::params {

    notify { "Installing and configuring ${logstash_pkg}": }

    anchor { 'logconsumer::begin': } ->
    class { '::logconsumer::accounts': } ->
    class { '::logconsumer::install': } ->
    class { '::logconsumer::config': } ->
    class { '::logconsumer::service': } ->
    anchor { 'logconsumer::end': }

}


# vim: set ts=2 sw=2 et :
