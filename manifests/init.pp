# Class: libnss_mysql
# ===========================
#
# Install and configure libnss_mysql.
#
# Parameters
# ----------
#
# Actions
# ----------
#
#   - Install libnss-mysql
#
# Examples
# --------
#
#    class { 'libnss_mysql': }
#
# Authors
# -------
#
# Bjoern Becker <mail@beli-consulting.com>
#
# Copyright
# ---------
#
# Copyright 2018 Bjoern Becker, unless otherwise noted.
#
class libnss_mysql (
  Boolean $package_manage           = true,
  String $package_name              = $::libnss_mysql::params::package_name,
  String $package_ensure            = 'installed',
  Boolean $config_manage            = false,
  Optional[Hash] $config_parameters = undef,
) inherits ::libnss_mysql::params {

  include '::libnss_mysql::install'

  anchor { 'libnss_mysql::start': }
  anchor { 'libnss_mysql::end': }

  if $config_manage {
    create_resources('class', { '::libnss_mysql::config' => $config_parameters } )

    Anchor['libnss_mysql::start']
    -> Class['libnss_mysql::install']
    -> Class['libnss_mysql::config']
    -> Anchor['libnss_mysql::end']
  } else {
    Anchor['libnss_mysql::start']
    -> Class['libnss_mysql::install']
    -> Anchor['libnss_mysql::end']
  }
}
