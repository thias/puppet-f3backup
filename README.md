# F3 Backup

## Overview

Simple filesystem-level backup solution based on rdiff-backup over ssh.

## Examples

Server Example :

    # The main backup server
    class { 'f3backup::server': }
    # The server can't back itself up, rdiff thinks it's already running
    class { 'f3backup': backup_rdiff => false }

    # More complex example
    class { '::f3backup::server':
      backup_home               => '/srv/backup',
      rdiff_global_exclude_file => '/etc/f3backup-exclude.txt, /srv/backup/f3backup/%server%/exclude.txt',
      cron_mailto               => 'jdoe@example.com',
      ssh_config_hosts          => {
        'server1.example.com' => [
          'Port 1234',
        ],
      },
    }

Client Examples :

    # Enable full filesystem backup (from site.pp for all nodes)
    include f3backup
    # Disable full filesystem backup on a node
    class { 'f3backup':
        backup_rdiff => false,
    }
    # Exclude filesystem paths from the backup on a node
    f3backup::exclude {'/var/lib/mysql/**': }

SSH keys are automatically exported on the server(s) and realized on client nodes.

Testing or forcing a backup run :

# su - backup
$ f3backup -r node1.example.com /etc/f3backup.ini

Configurable options:
 * backup_home (default='/backup') Base folder to put the f3backup folder containing all backups.
 * backup_server (default='default') Backup server that should perform backups on this client.
 * myname (default=$::fqdn) Name of the server, by default it's full qualified domain name.
 * ensure (default=present) Ensure backup is present or absent.
 * backup_rdiff (default=true): if true will run an rdiff-backup for the full filesystem
 * backup_command (default=false): if true will run a specific command after all backups have finished
 * priority (default=10) Priority to perform the backup.
 * rdiff_keep (default=4W): time to keep the rdiff-backups
 * rdiff_global_exclude_file  (default=""): array with the directories to be excluded. Each specified directory will be added to the local exclude file. The format should be the same as in rdiff-backup.
 * rdiff_user (default='backup') User to use when performing the rdiff backups.
 * rdiff_path (default='/') Base path for the rdiff backup.
 * rdiff_extra_parameters (default=""): extra parameters to be passed to rdiff-backup.
 * command_to_execute (default='/bin/true') Command to execute when performing the command backup.

