# == Class: pnp4nagios
#
# This will setup pnp4nagios using various methods
# It will pull in variables from my monitoring module to decide what to do so it shouldn't need any setup
#
# === Parameters
#
# All parameters are set in the params class
#
# [*ensure*]
#   ensuring whether pnp4nagios is present or not
#   
# [*monotiring_type*]
#   Type of monitoring server you have
#   Will get this from the hiera variable monitoring::params::monitoring_type
#   
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { pnp4nagios:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Pete Brown <rendhalver@gmail.com>
#
# === Copyright
#
# Copyright 2013 Pete Brown, unless otherwise noted.
#
class pnp4nagios (
  $ensure          = $::pnp4nagios::params::ensure,
  $monitoring_type = $::pnp4nagios::params::monitoring_type,
  $log_type        = $::pnp4nagios::params::log_type,
  $debug_lvl       = $::pnp4nagios::params::debug_lvl
) inherits ::pnp4nagios::params {

  validate_re($ensure, '^(present|absent)$')
  validate_re($log_type, '^(syslog|file)$',
    "${log_type} is not supported for log_type.  Allowed values are 'syslog' and 'file'.")
  validate_re($monitoring_type, '^(icinga|nagios)$',
    "${monitoring_type} is not supported for monitoring_type.  Allowed values are 'icinga' and 'nagios'.")
  validate_integer($debug_lvl)
  class{'pnp4nagios::install':} ->
  class{'pnp4nagios::config':} ~>
  class{'pnp4nagios::service':} 
}
