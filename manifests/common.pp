# Common to clients and servers
#
class f3backup::common {

  package { 'rdiff-backup': ensure => 'installed' }

}

