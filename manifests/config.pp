# Config class
#
class pnp4nagios::config (
  $user            = $::pnp4nagios::user,
  $group           = $::pnp4nagios::group,
  $log_type        = $::pnp4nagios::log_type,
  $debug_lvl       = $::pnp4nagios::debug_lvl
) {

  file { '/etc/pnp4nagios/npcd.cfg':
    notify  => Class[pnp4nagios::service],
    content => template('pnp4nagios/etc/pnp4nagios/npcd.cfg.erb'),
  }

  file { '/etc/pnp4nagios/config.php':
    notify  => Class[pnp4nagios::service],
    content => template('pnp4nagios/etc/pnp4nagios/config.php.erb'),
  }

  file { '/var/log/pnp4nagios':
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0775',
  }

  file { '/var/log/pnp4nagios/kohana':
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0775',
  }

  file { '/var/log/pnp4nagios/stats':
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0775',
  }

  file { '/var/lib/pnp4nagios':
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0775',
  }

  file { '/var/spool/pnp4nagios':
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0755',
  }

}

