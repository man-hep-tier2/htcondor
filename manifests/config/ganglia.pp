class htcondor::config::ganglia {
  $ganglia_cluster_name       = $htcondor::ganglia_cluster_name
  $template_ganglia           = $htcondor::template_ganglia
  if $ganglia_cluster_name {
    file { '/etc/condor/config.d/23_ganglia.config':
      content => template($template_ganglia),
      require => Package['condor'],
      owner   => $htcondor::condor_user,
      group   => $htcondor::condor_group,
      mode    => '0644',
      notify  => Exec['/usr/sbin/condor_reconfig'],
    }
  }
}
