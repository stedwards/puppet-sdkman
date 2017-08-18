class sdkman::install(
  $ensure = $sdkman::install::ensure,
  $prefix = $sdkman::install::prefix,
  $user   = $sdkman::install::user,
) {
  $_sdkman_init = "source /Users/${::boxen_user}/.sdkman/bin/sdkman-init.sh"

  exec { 'selfupdate-sdkman':
    command => "bash --login -c '${_sdkman_init} && sdk selfupdate'",
    onlyif  => "test -e /Users/${::boxen_user}/.sdkman/etc/config",
    before  => File["${boxen::config::envdir}/sdkmanenv.sh"],
  }

  exec { 'install-sdkman':
    command => 'curl -s "https://get.sdkman.io" | bash',
    creates => "/Users/${::boxen_user}/.sdkman/etc/config",
    require => Exec['selfupdate-sdkman'],
    before  => File["${boxen::config::envdir}/sdkmanenv.sh"],
  }

  file { "${boxen::config::envdir}/sdkmanenv.sh":
    ensure  => file,
    content => "source /Users/${::boxen_user}/.sdkman/bin/sdkman-init.sh\n",
  }
}
