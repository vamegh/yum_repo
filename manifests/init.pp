# module :: yum_repo
# v hedayati 2015
#
class yum_repo {
  $yum_repos = hiera_hash('yum_repos')

  if ($yum_repos) {
    create_resources('yum_repo::add_repo', $yum_repos)
  }
}

