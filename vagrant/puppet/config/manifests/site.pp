
class { 'java':
    distribution => 'jdk',
    version => 'latest',
}

class { 'motd':
    template => 'custom/motd.erb'
}

class { 'postgresql::server': }

class { 'postgresql::lib::java': }
