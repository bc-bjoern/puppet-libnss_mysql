# @summary 
#   Private class for managing libnss-mysql package.
#
#
#
class libnss_mysql::install {
  if $libnss_mysql::package_manage {
    package { 'libnss_mysql':
      ensure => $libnss_mysql::package_ensure,
      name   => $libnss_mysql::package_name,
    }
  }
}
