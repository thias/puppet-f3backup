class f3backup (
  $backup_home   = '/backup',
  $backup_server = 'default',
  $myname        = $::fqdn,
  $ensure        = 'directory',
) {

  include '::f3backup::common'

  if ( $myname == '' or $myname == undef ) {
    fail('myname must not be empty')
  }

  if $ensure != 'absent' {
    @@concat { "${backup_home}/f3backup/${myname}/exclude.txt":
      owner   => 'backup',
      group   => 'backup',
      mode    => '0644',
      force   => true,
      ensure_newline => true,
      tag     => "f3backup-${backup_server}",
    }
    @@concat { "${backup_home}/f3backup/${myname}/include.txt":
      owner   => 'backup',
      group   => 'backup',
      mode    => '0644',
      force   => true,
      ensure_newline => true,
      tag     => "f3backup-${backup_server}",
    }
  }

  @@file { "${backup_home}/f3backup/${myname}":
    # To support 'absent', though force will be needed
    ensure => $ensure,
    owner  => 'backup',
    group  => 'backup',
    mode   => '0644',
    tag    => "f3backup-${backup_server}",
  }

#  # Install the client's host ssh key on the backup server
#  @@sshkey { $fqdn:
#    ensure => present,
#    key    => $sshrsakey,
#    type   => 'ssh-rsa',
#    tag    => "f3backup-${backup_server}",
#  }

}
