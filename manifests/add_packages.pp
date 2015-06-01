# module yum_repo :: add_packages
# v hedayati 2015
#
define yum_repo::add_packages (
  $pkg_name   = $title,
  $ensure    = '',
) {
  notify {"Package Name :: $pkg_name , ensure :: $ensure ":}

  package { $pkg_name:
    ensure => $ensure,
    name   => $pkg_name,
  }
}

