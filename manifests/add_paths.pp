# module yum_repos::add_paths
# v hedayati 2015
#  -- this may seem stupid but we can now just recurse through a
# hiera hash and create all the paths.
define yum_repos::add_paths (
  $name        = $title,
  $ensure      = '',
  $path        = '',
  $owner       = '',
  $group       = '',
  $mode        = '',
  $recurse     = '',
  $content     = '',
  $source      = '',
  $ignore      = '',
) {
  notify {"Path Name :: $name :: $path :: $ensure ":}

  file { $name:
    path => $path,
    if !empty($ensure) {
      ensure => $ensure,
    }
    if !empty($owner) {
      owner => $owner,
    }
    if !empty($group) {
      group => $group,
    }
    if !empty($mode) {
      mode => $mode,
    }
    if !empty($recurse) {
      recurse => $recurse,
    }
    if !empty($content) {
      content => $content,
    }
    if !empty($source) {
      source => $source,
    }
    if !empty($ignore) {
      ignore => $ignore,
    }
  }
}

