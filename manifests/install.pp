# Install pnp4nagios
#

class pnp4nagios::install (
  $ensure          = $::pnp4nagios::ensure,
  $monitoring_type = $::pnp4nagios::monitoring_type
) {

  if $monitoring_type == 'icinga' {
    $packages = ['pnp4nagios', 'icinga-web-pnp']
  } else {
    $packages = ['pnp4nagios']
  }
  package { $packages:
    ensure => $ensure,
  }
}
