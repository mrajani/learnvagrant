node default {
}

node 'nodeb.iono.corp' {
  class { 'nginx': 
    # service_ensure => 'stopped',
    # package_ensure => 'absent',
    service_ensure => 'running',
    package_ensure => 'present',
  }

  nginx::resource::vhost { 'nodeb.iono.corp':
    # ensure   => 'absent',
    ensure   => 'present',
    www_root => '/var/www/nodeb.iono.corp',
    use_default_location => true,
    server_name => ['node'],
  }

  $dirs = [
     '/var/www',
     '/var/www/nodeb.iono.corp',
  ]     
  file { $dirs:
    ensure => directory, 
  }  
}
