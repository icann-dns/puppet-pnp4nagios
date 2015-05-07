# Manage service
#

class pnp4nagios::service (
  $ensure = $::pnp4nagios::ensure
) {
  if $ensure == 'present' { 
    $enable         = true
    $service_ensure = 'running'
  } else {
    $enable         = true
    $service_ensure = 'stopped'
  }


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
    ensure     => $service_ensure,
    provider   => $provider,
    enable     => $enable,
    hasstatus  => true,
    hasrestart => true,
  }
}

