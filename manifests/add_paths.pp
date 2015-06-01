# module yum_repos::add_paths
# v hedayati 2015
#  -- this may seem stupid but we can now just recurse through a
# hiera hash and create all the paths.
define yum_repo::add_paths (
  $path_name   = $title,
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
  #notify {"Path Name :: $name :: $path :: $ensure ":}
  ## PITA :: This should be just a check inside the file clause ...
  ## cant do that so we resort to this nastiness:

  if !empty("$ensure") {
    File { ensure => $ensure, }
  }

  if !empty("$owner") {
    File { owner => $owner, }
  }

  if !empty("$group") {
    File { group => $group, }
  }

  if !empty("$mode") {
    File { mode => $mode, }
  }

  if !empty("$recurse") {
    File { recurse => $recurse, }
  }

  if !empty("$content") {
    File { content => $content }
  }

  if !empty("$source") {
    File { source => $source, }
  }

  if !empty("$ignore") {
    File { ignore => $ignore, }
  }

  file { $path_name:
    path => $path,
  }

}

