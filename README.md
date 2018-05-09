# libnss_mysql

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with libnss_mysql](#setup)
    * [What libnss_mysql affects](#what-libnss_mysql-affects)
    * [Beginning with libnss_mysql](#beginning-with-libnss_mysql)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Limitations - OS compatibility, etc.](#limitations)

## Description

This Module manage libnss-mysql.

## Setup

### What libnss_mysql affects optionaly

* /etc/nsswitch.conf
* nscd service (TODO)

### Beginning with libnss_mysql

```
  class {'libnss-mysql': }
```

### Profile Example

```
######################################################################
# Class: profile::libnss_mysql                                       #
######################################################################
class profile::libnss_mysql(
  Hash $libnss_mysql_settings = hiera('libnss_mysql')
) inherits profile {

  create_resources('class', { '::libnss_mysql' => $libnss_mysql_settings})
}
```

## Usage

```
class {'libnss_mysql':
  config_manage => true,
}

class {'libnss_mysql::config':
  username => 'foo',
  password => 'bar',
}
```

### Hiera Examples 

```
libnss_mysql:
  config_manage: true
  config_parameters:
    username: 'proftp'
    password: "%{hiera('mysql_password')}"
    host: '192.168.0.5'
    database: 'ftp'
    getpwnam: "SELECT username,'x',uid,gid,'MySQL User', home,shell FROM users WHERE username='%1$s' LIMIT 1"
    getpwuid: "SELECT username,'x',uid,gid,'MySQL User', home,shell FROM users WHERE uid='%1$u' LIMIT 1"
    getspnam: "SELECT username,passwd,'1','0','99999','0','0','-1','0' FROM users WHERE username='%1$s' LIMIT 1"
    getpwent: "SELECT username,'x',uid,gid,'MySQL User', home,shell FROM users"
    getspent: "SELECT username,passwd,'1','0','99999','0','0','-1','0' FROM users"
    getgrnam: "SELECT groupname,'x',gid FROM groups WHERE groupname='%1$s' LIMIT 1"
    getgrgid: "SELECT groupname,'x',gid FROM groups WHERE gid='%1$u' LIMIT 1"
    getgrent: "SELECT groupname,'x',gid FROM groups"
    memsbygid: "SELECT u.username FROM users_groups ug, users u, groups g WHERE g.id = ug.groups_id and u.id = ug.users_id and g.gid='%1$u'"
    gidsbymem: "SELECT g.gid FROM users_groups ug, users u, groups g WHERE g.id = ug.groups_id and u.id = ug.users_id and u.username='%1$s'"
    nsswitch_manage: true
```

## Reference

### Classes

#### Public Classes
* libnss_mysql: Main class, includes all other classes.

#### Private Classes

* libnss_mysql::install: Handles the packages.
* libnss_mysql::config: Handles configuration and cron files.
* libnss_mysql::params: default values.

## Limitations

 * Tested with RedHat OS Family only 
 * Add "mysql" to nsswitch.conf isn't very nice for preexisting values
