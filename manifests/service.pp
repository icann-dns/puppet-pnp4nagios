# Manage service
#

class pnp4nagios::service (
  $ensure = $::pnp4nagios::ensure
) {
  $enable = $ensure ? { present => true, absent => false }

  case $::lsbdistdescription {
    ## some tricky logic to use systemd on fedora 17+
    /Fedora release (.+)/: {
      if versioncmp($1,'17') >= 0 {
        $servicename = 'npcd.service'
        $provider = 'systemd'
      }
    }
    default: {
      $servicename = 'npcd'
      $provider = undef
    }
  }
  service { $servicename:
    ensure     => $ensure,
    provider   => $provider,
    enable     => $enable,
    hasstatus  => true,
    hasrestart => true,
  }
}

