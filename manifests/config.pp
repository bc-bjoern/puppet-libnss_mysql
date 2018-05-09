# @summary 
#   Private class for configuring libnss-mysql.
#
# 
#
class libnss_mysql::config(
  String $username,
  String $password,
  Optional[String] $getpwnam      = undef,
  Optional[String] $getpwuid      = undef,
  Optional[String] $getspnam      = undef,
  Optional[String] $getpwent      = undef,
  Optional[String] $getspent      = undef,
  Optional[String] $getgrnam      = undef,
  Optional[String] $getgrgid      = undef,
  Optional[String] $getgrent      = undef,
  Optional[String] $memsbygid     = undef,
  Optional[String] $gidsbymem     = undef,
  String $host                    = 'localhost',
  Optional[String] $database      = undef,
  Optional[String] $socket        = undef,
  Optional[Integer] $port         = undef,
  Optional[Boolean] $notify_nscd  = false,
  String $template_config         = 'config',
  String $template_config_root    = 'config_root',
  String $libnss_config           = $::libnss_mysql::params::libnss_config,
  String $libnss_config_root      = $::libnss_mysql::params::libnss_config_root,
  Boolean $nsswitch_manage        = false,
  Boolean $nsswitch_ensure        = true,
) inherits libnss_mysql::params {

  if $libnss_mysql::config_manage {
    if $notify_nscd {
      file{ $libnss_config:
        ensure  => $package_ensure,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template("${module_name}/${::osfamily}_${template_config}.erb"),
        notify  => Service['nscd'],
      }

      file{ $libnss_config_root:
        ensure  => $package_ensure,
        owner   => 'root',
        group   => 'root',
        mode    => '0600',
        content => template("${module_name}/${::osfamily}_${template_config_root}.erb"),
        notify  => Service['nscd'],
      }
    } else {
      file{ $libnss_config:
        ensure  => $package_ensure,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template("${module_name}/${::osfamily}_${template_config}.erb"),
      }

      file{ $libnss_config_root:
        ensure  => $package_ensure,
        owner   => 'root',
        group   => 'root',
        mode    => '0600',
        content => template("${module_name}/${::osfamily}_${template_config_root}.erb"),
      }
    }
  }

  if $nsswitch_manage {
    if $nsswitch_ensure {
      $augeas_action = 'set'
    } else {
      $augeas_action = 'rm'
    }

    augeas {'nsswitch add mysql':
      context => '/files/etc/nsswitch.conf',
      changes => [
      "${augeas_action} /files/etc/nsswitch.conf/*[self::database = 'group']/service[3] mysql",
      "${augeas_action} /files/etc/nsswitch.conf/*[self::database = 'passwd']/service[3] mysql",
      "${augeas_action} /files/etc/nsswitch.conf/*[self::database = 'initgroups']/service[2] mysql",
      ],
    }
  }
}
