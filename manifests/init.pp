# Class: htcondor
#
# This module manages htcondor. Parameters that refer to condor 'knobs' (e.g.
# CONDOR_ADMIN) will not be explained here.
# Instead please refer to the HTCondor documentation:
# http://research.cs.wisc.edu/htcondor/manual/latest/3_3Configuration.html
#
# Defaults for the parameters can be found in htcondor::params
#
# == Parameters:
#
# [*accounting_groups*]
# Accounting grous (and subgroups) for fair share configuration.
# Requires use_accounting_groups = true
# Default just provides an example for what needs to be specified
#
# [*cluster_has_multiple_domains*]
# Specifies if the cluster has more than one domain. If true it will set
# TRUST_UID_DOMAIN = True in 10_security.config
#
# [*collector_name*]
# Sets COLLECTOR_NAME in 22_manager.config
# Default: 'Personal Condor at $(FULL_HOSTNAME)'
#
# [*schedulers*]
# List of schedulers that are allowed to submit jobs to the HTCondor pool
#
# [*admin_email*]
# Sets CONDOR_ADMIN
# (http://research.cs.wisc.edu/htcondor/manual/latest/3_3Configuration.html).
#
# [*custom_attribute*]
# Can be used to specify a ClassAd via custom_attribute = True. This is useful
# when creating queues with ARC CEs
# Default: NORDUGRID_QUEUE
#
# [*high_priority_groups*]
# A hash of groups with high priority. It is used for the group sorting
# expression for condor. Groups with lower value are considered first.
# example:
# $high_priority_groups = {
#                         'cms.admin' => -30,
#                         'ops'       => -20,
#                         'dteam'     => -10,
#                         }
# This will consider the group cms.admin first, followed by ops and dteam.
#
# [*include_username_in_accounting*]
# Bool. If false the accounting groups used are of the form
# group_<group_name>.<subgroup>
# and if true
# group_<group_name>.<subgroup>.<user name>
#
# [*install_repositories*]
# Bool to install repositories or not
#
# [*$is_scheduler*]
# If current machine is a condor scheduler
#
# [*is_manager*]
# If machine is a manager or a negotiator (condor term)
#
# [*is_worker*]
# If the machine is a worker node
#
# [*machine_owner*]
# The owner of the machine (e.g. an accounting group)
#
# [*managers*]
# List of condor managers
#
# [*number_of_cpus*]
# Number of CPUs available for condor scheduling. This is set for worker nodes
# only
#
# [*pool_password*]
# Path to pool password file.
#
# [*uid_domain*]
# Condor UID_DOMAIN
# Default: example.com
#
# [*use_accounting_groups*]
# If accounting groups should be used (fair shares)
#
# [*worker_nodes*]
# List of worker nodes
#
#
# Templates parameters : these parameters allow for user to override the default
# templates, for their needs, ie for instance for a different fairshare
#
#  $template_config_local
#  $template_security
#  $template_resourcelimits
#  $template_schedd
#  $template_fairshares
#  $template_manager
#  $template_workernode
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
class htcondor (
  $accounting_groups              = $htcondor::params::accounting_groups,
  $cluster_has_multiple_domains   =
  $htcondor::params::cluster_has_multiple_domains,
  $collector_name                 = $htcondor::params::collector_name,
  $email_domain                   = $htcondor::params::email_domain,
  $schedulers                     = $htcondor::params::schedulers,
  $admin_email                    = $htcondor::params::admin_email,
  $condor_priority                = $htcondor::params::repo_priority,
  $condor_version                 = $htcondor::params::condor_version,
  $custom_attribute               = $htcondor::params::custom_attribute,
  $enable_cgroup                  = $htcondor::params::enable_cgroup,
  $enable_multicore               = $htcondor::params::enable_multicore,
  $enable_healthcheck             = $htcondor::params::enable_healthcheck,
  $high_priority_groups           = $htcondor::params::high_priority_groups,
  $priority_halflife              = $htcondor::params::priority_halflife,
  $default_prio_factor            = $htcondor::params::default_prio_factor,
  $group_accept_surplus           = $htcondor::params::group_accept_surplus,
  $group_autoregroup              = $htcondor::params::group_autoregroup,
  $health_check_script            = $htcondor::params::health_check_script,
  $include_username_in_accounting =
  $htcondor::params::include_username_in_accounting,
  $use_pkg_condor_config          = $htcondor::params::use_pkg_condor_config,
  $install_repositories           = $htcondor::params::install_repositories,
  $dev_repositories               = $htcondor::params::dev_repositories,
  $is_scheduler                   = $htcondor::params::is_scheduler,
  $is_manager                     = $htcondor::params::is_manager,
  $is_worker                      = $htcondor::params::is_worker,
  $machine_owner                  = $htcondor::params::machine_owner,
  $managers                       = $htcondor::params::managers,
  $number_of_cpus                 = $htcondor::params::number_of_cpus,
  $partitionable_slots            = $htcondor::params::partitionable_slots,
  $memory_overcommit              = $htcondor::params::memory_overcommit,
  $request_memory                 = $htcondor::params::request_memory,
  $certificate_mapfile            = $htcondor::params::certificate_mapfile,
  $kerberos_mapfile               = $htcondor::params::kerberos_mapfile,
  $pool_home                      = $htcondor::params::pool_home,
  $pool_create                    = $htcondor::params::pool_create,
  $queues                         = $htcondor::params::queues,
  $periodic_expr_interval         = $htcondor::params::periodic_expr_interval,
  $max_periodic_expr_interval     =
  $htcondor::params::max_periodic_expr_interval,
  $remove_held_jobs_after         = $htcondor::params::remove_held_jobs_after,
  $leave_job_in_queue             = $htcondor::params::leave_job_in_queue,
  $ganglia_cluster_name           = $htcondor::params::ganglia_cluster_name,
  $pool_password                  = $htcondor::params::pool_password_file,
  $uid_domain                     = $htcondor::params::uid_domain,
  $default_domain_name            = $htcondor::params::default_domain_name,
  $filesystem_domain              = $htcondor::params::filesystem_domain,
  $use_accounting_groups          = $htcondor::params::use_accounting_groups,
  $workers                        = $htcondor::params::workers,
  # default params
  $condor_user                    = root,
  $condor_group                   = root,
  $condor_uid                     = 0,
  $condor_gid                     = 0,
  # template selection. Allow for user to override
  $template_config_local          = $htcondor::params::template_config_local,
  $template_security              = $htcondor::params::template_security,
  $template_resourcelimits        = $htcondor::params::template_resourcelimits,
  $template_queues                = $htcondor::params::template_queues,
  $template_schedd                = $htcondor::params::template_schedd,
  $template_fairshares            = $htcondor::params::template_fairshares,
  $template_manager               = $htcondor::params::template_manager,
  $template_ganglia               = $htcondor::params::template_ganglia,
  $template_workernode            = $htcondor::params::template_workernode,
  $template_defrag                = $htcondor::params::template_defrag,
  $template_highavailability      =
  $htcondor::params::template_highavailability,
  $use_htcondor_account_mapping   =
  $htcondor::params::use_htcondor_account_mapping,
  $use_fs_auth                    = $htcondor::params::use_fs_auth,
  $use_password_auth              = $htcondor::params::use_password_auth,
  $use_kerberos_auth              = $htcondor::params::use_kerberos_auth,
  $use_claim_to_be_auth           = $htcondor::params::use_claim_to_be_auth,
  $use_cert_map_file              = $htcondor::params::use_cert_map_file,
  $use_krb_map_file               = $htcondor::params::use_krb_map_file,
  $use_pid_namespaces             = $htcondor::params::use_pid_namespaces,
  $cert_map_file                  = $htcondor::params::cert_map_file,
  $krb_map_file                   = $htcondor::params::krb_map_file,
  $machine_list_prefix            = $htcondor::params::machine_list_prefix,
  $max_walltime                   = $htcondor::params::max_walltime,
  $max_cputime                    = $htcondor::params::max_cputime,) inherits
::htcondor::params {
  class { 'htcondor::repositories':
    install_repos   => $install_repositories,
    dev_repos       => $dev_repositories,
    condor_priority => $condor_priority,
  }

  class { 'htcondor::install':
    ensure    => $condor_version,
    dev_repos => $dev_repositories,
  }

  class { 'htcondor::config':
    accounting_groups              => $accounting_groups,
    cluster_has_multiple_domains   => $cluster_has_multiple_domains,
    collector_name                 => $collector_name,
    custom_attribute               => $custom_attribute,
    enable_cgroup                  => $enable_cgroup,
    enable_multicore               => $enable_multicore,
    enable_healthcheck             => $enable_healthcheck,
    high_priority_groups           => $high_priority_groups,
    priority_halflife              => $priority_halflife,
    default_prio_factor            => $default_prio_factor,
    group_accept_surplus           => $group_accept_surplus,
    group_autoregroup              => $group_autoregroup,
    health_check_script            => $health_check_script,
    include_username_in_accounting => $include_username_in_accounting,
    use_pkg_condor_config          => $use_pkg_condor_config,
    is_manager                     => $is_manager,
    is_worker                      => $is_worker,
    machine_owner                  => $machine_owner,
    managers                       => $managers,
    number_of_cpus                 => $number_of_cpus,
    partitionable_slots            => $partitionable_slots,
    memory_overcommit              => $memory_overcommit,
    request_memory                 => $request_memory,
    certificate_mapfile            => $certificate_mapfile,
    kerberos_mapfile               => $kerberos_mapfile,
    pool_home                      => $pool_home,
    queues                         => $queues,
    periodic_expr_interval         => $periodic_expr_interval,
    max_periodic_expr_interval     => $max_periodic_expr_interval,
    remove_held_jobs_after         => $remove_held_jobs_after,
    leave_job_in_queue             => $leave_job_in_queue,
    ganglia_cluster_name           => $ganglia_cluster_name,
    pool_password                  => $pool_password,
    pool_create                    => $pool_create,
    uid_domain                     => $uid_domain,
    default_domain_name            => $default_domain_name,
    filesystem_domain              => $filesystem_domain,
    use_accounting_groups          => $use_accounting_groups,
    workers                        => $workers,
    condor_user                    => $condor_user,
    condor_group                   => $condor_group,
    condor_uid                     => $condor_uid,
    condor_gid                     => $condor_gid,
    use_htcondor_account_mapping   => $use_htcondor_account_mapping,
    use_fs_auth                    => $use_fs_auth,
    use_password_auth              => $use_password_auth,
    use_kerberos_auth              => $use_kerberos_auth,
    use_claim_to_be_auth           => $use_claim_to_be_auth,
    use_cert_map_file              => $use_cert_map_file,
    use_krb_map_file               => $use_krb_map_file,
    use_pid_namespaces             => $use_pid_namespaces,
    cert_map_file                  => $cert_map_file,
    krb_map_file                   => $krb_map_file,
    machine_list_prefix            => $machine_list_prefix,
    max_walltime                   => $max_walltime,
    max_cputime                    => $max_cputime,
  }

  class { 'htcondor::service':
  }

  Class['htcondor::repositories'] -> Class['htcondor::install'] -> Class['htcondor::config'
    ] -> Class['htcondor::service']
}
