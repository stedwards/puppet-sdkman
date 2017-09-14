class sdkman::install(
  $ensure = $sdkman::install::ensure,
  $prefix = $sdkman::install::prefix,
  $user   = $sdkman::install::user,
) {

  exec { 'install-sdkman':
    command     => "bash --login -c 'export SDKMAN_DIR=\"${::boxen_home}/sdkman\" && curl -s \"https://get.sdkman.io\" | bash'",
    creates     => "${::boxen_home}/sdkman/etc/config",
    environment => ["SDKMAN_DIR=${::boxen_home}/sdkman"],
    before      => File["${boxen::config::envdir}/sdkmanenv.sh"],
  }

  file { "${boxen::config::envdir}/sdkmanenv.sh":
    ensure  => file,
    content => "SDKMAN_DIR=${::boxen_home}/sdkman\nsource ${::boxen_home}/sdkman/bin/sdkman-init.sh\n",
  }
}
