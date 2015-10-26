class crond (
  $package_ensure = $crond::params::package_ensure,
  $service_ensure = $crond::params::service_ensure,
  $service_enable = $crond::params::service_enable,
  $package_name = $crond::params::package_name,
  $service_name = $crond::params::service_name,
) inherits crond::params {
  include crond::install, crond::service
}

class crond::params {
  $package_ensure = 'present'
  $service_ensure = 'running'
  $service_enable = true
  
  # centos
  $package_name = 'cronie'
  $service_name = 'crond'
}

class crond::install {
  package { $crond::package_name:
    ensure => $crond::package_ensure,
  }
}

class crond::service {
  service { $crond::service_name:
    require => Class['crond::install'],
    ensure => $crond::service_ensure,
    enable => $crond::service_enable,
  }
}
