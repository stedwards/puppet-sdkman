define sdkman::groovyserv(
  $ensure = 'installed',
  $version = $name,
  $default = false
) {
  require sdkman::install

  exec { "install-groovyserv-$name":
    command     => "bash --login -c 'sdk install groovyserv ${version}'",
    environment => ["SDKMAN_DIR=${::boxen_home}/sdkman"],
    creates     => "${::boxen_home}/sdkman/candidates/groovyserv/${version}"
  }

  if($default) {
    exec { "set-groovyserv-default":
      command => "bash --login -c 'sdk default groovyserv ${version}'",
      require => Exec["install-groovyserv-$name"],
    }
  }
}
