# Class htcondor::service
#
# Starts the services for HTCondor
class htcondor::service(
  $ensure = 'running',
  $enable = true,
) {
  service { 'condor':
    ensure     => $ensure,
    enable     => $enable,
    hasrestart => true,
    hasstatus  => true,
  }

  # this exec is called from the config, but we can't run it if the condor
  # service is not up. it's a RE-config command assuming something is already up.
  exec{ '/usr/sbin/condor_reconfig':
    refreshonly => true,
    require     => Service['condor']
  }
}
