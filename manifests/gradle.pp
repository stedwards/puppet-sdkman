define sdkman::gradle(
  $ensure = 'installed',
  $version = $name,
  $default = false
) {
  require sdkman::install

  exec { "install-gradle-$name":
    command => "bash --login -c 'sdk install gradle ${version}'",
    creates => "${::boxen_home}/sdkman/candidates/gradle/${version}"
  }

  if($default) {
    exec { "set-gradle-default":
      command => "bash --login -c 'sdk default gradle ${version}'",
      require => Exec["install-gradle-$name"],
    }
  }
}
