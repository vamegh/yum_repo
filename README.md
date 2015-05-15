## Yum Module

### Usage
There is 2 ways this module can be used

#### Method 1 (Simple Method):
Within a specific manifest eg base.pp call :

```
yum_repo
```

Inside the base config file for hiera include a hash which contains the following elements:

```
yum_repos:
  somerepo:
    yum_server: "repository"
    repo_path: "repo_store/centos6.2/stable"
    enabled: "1"
    gpgcheck: "0"
    protect: "0"
    desc: "some repo"
```

#### Method 2 (Advanced Method):

This provides more granular calls and allows for proper customisation per role or class.

Inside base.pp add something similar to the following:

```
$base_repos = hiera_hash('base_repos')

if ($base_repos) {
  create_resources('yum_repo::add_repo', $base_repos)
}
```

inside the base hiera yaml file add the following:

```
base_repos:
  somerepo:
    yum_server: "repository"
    repo_path: "repo_store/centos6.2/stable"
    enabled: "1"
    gpgcheck: "0"
    protect: "0"
    desc: "some repo"

```

Really we should be creating the repos based on the os version, so again in the base.pp, something like the following could be done:


```
if (( $operatingsystem =~ /(?i:centos|redhat)/ ) and ( $operatingsystemrelease == 5 )) {
  $base_repos = hiera_hash('c5_base_repos')

  if ($base_repos) {
    create_resources('yum_repo::add_repo', $base_repos)
  }

} elsif (( $operatingsystem =~ /(?i:centos|redhat)/ ) and ( $operatingsystemrelease == 6 )) {

  $base_repos = hiera_hash('c6_base_repos')

  if ($base_repos) {
    create_resources('yum_repo::add_repo', $base_repos)
  }

} elsif (( $operatingsystem =~ /(?i:centos|redhat)/ ) and ( $operatingsystemrelease == 7 )) {

  $base_repos = hiera_hash('c7_base_repos')

  if ($base_repos) {
    create_resources('yum_repo::add_repo', $base_repos)
  }
} else {
  // add a notify :: notify("didnt match os")
}

```

Within the base yaml file, 3 different hashes are added for each os version so something like the following:

```
c5_base_repos:
  somerepo:
    yum_server: "repository"
    repo_path: "repo_store/<whatever>/centos5/stable"
    enabled: "1"
    gpgcheck: "0"
    protect: "0"
    desc: "some repo"
  somerepo2:
    yum_server: "repository"
    repo_path: "repo_store/<whatever>/centos5/stable"
    enabled: "1"
    gpgcheck: "0"
    protect: "0"
    desc: "some repo 2"

c6_base_repos:
  somerepo:
    yum_server: "repository"
    repo_path: "repo_store/<whatever>/centos6/stable"
    enabled: "1"
    gpgcheck: "0"
    protect: "0"
    desc: "some repo"
  somerepo2:
    yum_server: "repository"
    repo_path: "repo_store/<whatever>/centos6/stable"
    enabled: "1"
    gpgcheck: "0"
    protect: "0"
    desc: "some repo 2"

c7_base_repos:
  somerepo:
    yum_server: "repository"
    repo_path: "repo_store/<whatever>/centos7/stable"
    enabled: "1"
    gpgcheck: "0"
    protect: "0"
    desc: "some repo"
  somerepo2:
    yum_server: "repository"
    repo_path: "repo_store/<whatever>/centos7/stable"
    enabled: "1"
    gpgcheck: "0"
    protect: "0"
    desc: "some repo 2"
```

This is 1 possible method, another method would be to construct the repo_path based on osversion.



Finally once the base is configured, it is then possible to get granular with each specific role, so for example lets say the server role is a web server and it requires custom web repos, assuming the role manifest is called web.pp, inside web.pp the following can be added:

```
$web_repos = hiera_hash('c6_web_repos')

if ($web_repos) {
  create_resources('yum_repo::add_repo', $web_repos)
}
```

Again like above checks can be put in to add specific repos based on os version, and the corresponding web role yaml file would include something along the lines of the following:

```
c6_web_repos:
  somewebrepo:
    yum_server: "repository"
    repo_path: "repo_store/<whatever>/centos7/stable"
    enabled: "1"
    gpgcheck: "0"
    protect: "0"
    desc: "some web repo"
  somewebrepo2:
    yum_server: "repository"
    repo_path: "repo_store/<whatever>/centos7/stable"
    enabled: "1"
    gpgcheck: "0"
    protect: "0"
    desc: "some web repo 2"
```




