# Land Registry's log-consumer Install

A puppet module to manage the logstash install for inserting into ELK.

## Requirements

* Puppet  >=  3.4
* The [stdlib](https://forge.puppetlabs.com/puppetlabs/stdlib) Puppet library.

## Usage

### Main class

```
class ( 'log-consumer' )

This puppet module installs the logstash tool that pulls all messages from the rabbitmq queue and drops the messages into Elastic search.
The logstash_push module is only required on the elastic search server environment.
The install should happen at Elastic Search Monitoring environment install.

Logstash can either forward the messages unmodified to ELK or can index or label massages according to the log type before forwarding to ELK.

```
### Message Management

```
Location for message management is:  /etc/logstash/conf.d/

Ideally one config file per message type.
A sample config is below:

Filename:  10-syslog.conf
filter {
  if [type] == "syslog" {
    grok {
      match => { "message" => "%{SYSLOGTIMESTAMP:syslog_timestamp} %{SYSLOGHOST:syslog_hostname} %{DATA:syslog_program}(?:\[%{POSINT:syslog_pid}\])?: %{GREEDYDATA:syslog_message}" }
      add_field => [ "received_at", "%{@timestamp}" ]
      add_field => [ "received_from", "%{host}" ]
    }
    syslog_pri { }
    date {
      match => [ "syslog_timestamp", "MMM  d HH:mm:ss", "MMM dd HH:mm:ss" ]
    }
  }
}

# vim: set ts=2 sw=2 et :

```

### License

Please see the [LICENSE](https://github.com/LandRegistry-Ops/puppet-log-consumer/blob/master/LICENSE.md) file.

