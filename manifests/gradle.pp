define sdkman::gradle(
  $ensure = 'installed',
  $version = $name,
  $default = false
) {
  require sdkman::install

  exec { "install-gradle-$name":
    command     => "bash --login -c 'sdk install gradle ${version}'",
    environment => ["SDKMAN_DIR=${::boxen_home}/sdkman"],
    creates     => "${::boxen_home}/sdkman/candidates/gradle/${version}"
  }

  if($default) {
    exec { "set-gradle-default":
      command => "bash --login -c 'sdk default gradle ${version}'",
      require => Exec["install-gradle-$name"],
    }
  }
}
