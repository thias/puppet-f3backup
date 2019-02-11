# Class: f3backup::install
# ===========================
#
# private class to be included by init
#

class f3backup::install {

  include '::f3backup'

  if $::f3backup::package_manage {
    package { $::f3backup::package_name:
      ensure => $::f3backup::package_ensure,
    }
  }

}
