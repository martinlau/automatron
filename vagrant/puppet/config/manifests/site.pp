class { 'motd':
    template => 'custom/motd.erb'
}

class { 'java':
    distribution => 'jdk',
    version => 'latest'
}
