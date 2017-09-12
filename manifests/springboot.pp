define sdkman::springboot(
  $ensure = 'installed',
  $version = $name,
  $default = false
) {
  require sdkman::install

  exec { "install-springboot-$name":
    command => "bash --login -c 'sdk install springboot ${version}'",
    creates => "${::boxen_home}/sdkman/candidates/springboot/${version}"
  }

  if($default) {
    exec { "set-springboot-default":
      command => "bash --login -c 'sdk default springboot ${version}'",
      require => Exec["install-springboot-$name"],
    }
  }
}
