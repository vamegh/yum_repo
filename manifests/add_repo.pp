# module yum_repo :: add_repo
# v hedayati 2015
#
define yum_repo::add_repo (
  $yum_server = "repository",
  $repo_path  = "repo_store/centos6.2/stable",
  $reponame   = $title,
  $enabled    = "1",
  $gpgcheck   = "0",
  $gpgkey     = undef,
  $protect    = "0",
  $desc       = undef
) {
  yumrepo { $reponame:
    baseurl  => "http://${yum_server}/${repo_path}",
    enabled  => $enabled,
    gpgcheck => $gpgcheck,
    gpgcakey => $gpgkey,
    protect  => $protect,
    descr    => $desc
  }
}

