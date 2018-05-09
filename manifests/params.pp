# Class: libnss_mysql::params
#
# This class manages libnss-mysql parameters
#
# Parameters:
# - package_name
# - libnss_config
# - libnss_config_root
#
class libnss_mysql::params {
  if $::osfamily == 'RedHat' {
    $package_name         = 'libnss-mysql'
    $libnss_config        = '/etc/libnss-mysql.cfg'
    $libnss_config_root   = '/etc/libnss-mysql-root.cfg'
  } else {
    fail("Class['libnss_mysql::params']: Unsupported osfamily: ${::osfamily}")
  }
}

