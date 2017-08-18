class sdkman::install(
  $ensure = $sdkman::install::ensure,
  $prefix = $sdkman::install::prefix,
  $user   = $sdkman::install::user,
) {

  exec { 'install-sdkman':
    command => 'curl -s "https://get.sdkman.io" | bash',
    creates => "/Users/${::boxen_user}/.sdkman/etc/config",
    before  => File["${boxen::config::envdir}/sdkmanenv.sh"],
  }

  file { "${boxen::config::envdir}/sdkmanenv.sh":
    ensure  => file,
    content => "source /Users/${::boxen_user}/.sdkman/bin/sdkman-init.sh\n",
  }
}
