# The baseline for module testing used by Puppet Labs is that each manifest
# should have a corresponding test manifest that declares that class or defined
# type.
#
# Tests are then run by using puppet apply --noop (to check for compilation
# errors and view a log of events) or by fully applying the test in a virtual
# environment (to compare the resulting system state to the desired state).
#
# Learn more about module testing here:
# http://docs.puppetlabs.com/guides/tests_smoke.html
#
include logstash_pull
include account

# my account for testing 
class account {
  group { 'sysadm':
    ensure       => present,
    gid          => 500,
  }
  user { 'addi':
    ensure       => 'present',
    comment      => 'Addi,,,',
    gid          => '500',
    groups       => ['wheel', 'users'],
    managehome   => true,
    home         => '/home/addi',
    shell        => '/bin/bash',
    uid          => '500',
  }
  ssh_authorized_key { 'addi_ssh':
    user       => 'addi',
    type       => 'rsa',
    key    => "AAAAB3NzaC1yc2EAAAADAQABAAACAQCsFVhM9SHWwUvI6G8ucDAt9swHEoXm17iozlPUfriHBNexXJcjXvB5CLhZGrllqYrikVzicyKUEMPiQU78GKaos0rhoe8IalPGKwbcTaAFHkzBjaOd9bLpDVv9LAir3gHmfTw8koulmwl3r4AuEv3WdoRCTrddtqq7FmSFOby8yP6Yvt5ELhzpKxTZj4BJSlNQaGWRNVR/ObbIq4Qp6pbLpNh9oqcpZmuzLrURFck7a6TX3nlhgWRK7XYmcxPsR5vpNRVZruRNXQ2fF3mr5xakmqnH0YK9xhbMdVKF0C3xnkFKpUIp/iXGCIq86Y5IjQCXRZzL7dEoRND68q6docGzq2iZEUSo3fiLGuw50KUFdNUhY8qYxgoX7oL9bprD9TYg5dEyQLRzBxQUon2C0pGLGBdN4gVEmzK+Z0F0malH7i/15EjkE32Y/1fz0L63rGP9sRo9mRQR5T5ahQlNoBY5j9oJlDYpSNf9hJjFQWYZZuXOzOpUdHI2Qlxykr3Deut5GCzKZWFIlf4c8ZCHoNk9nPT+3YJityCDR5DpI+6a1lG7My3hfkQgFgzv7UrSU3aooY3zRJX7fHRxJagP43uuLVzkjU5rGuCLoVyWM0BKBwe2O6LxjKuxAh5iUVAZX3prUJu/5qrDG06ZAUrRmy3RW5PrIlq5ZIANPYTWmyl9Yw==",
  }
}
