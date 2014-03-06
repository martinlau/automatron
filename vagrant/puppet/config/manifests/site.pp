
class { 'motd':
    template => 'custom/motd.erb'
}

#package { 'mariadb-server':
#    ensure => 'latest'
#}
#
#package { 'java-devel':
#    ensure => 'latest'
#}
#
#package { 'tomcat':
#    ensure => 'latest'
#}
#
#package { 'mysql-connector-java':
#    ensure => 'latest'
#}
