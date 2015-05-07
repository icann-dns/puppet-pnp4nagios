# Default paramaters
#

class pnp4nagios::params {
  $ensure          = present
  $monitoring_type = 'icinga'
  $log_type        = 'file'
  $debug_lvl       = 0
  if defined(Class['icinga']) {
    $user  = $::icinga::icinga_user
    $group = $::apache::group
  } else {
    case $::lsbdistcodename {
      'trusty': {
        $user  = 'nagios'
        $group = 'nagios'
      }
      default: {
        $user  = 'icinga'
        $group = 'icinga'
      }
    }
  }
}
