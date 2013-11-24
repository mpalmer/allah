define allah::check($ensure  = present,
                    $source  = undef,
                    $content = undef) {
	File {
		mode    => 0555;
	}

	case $ensure {
		present: {
			if length(compact($source, $content)) != 1 {
				fail("Exactly one of source and content must be specified when ensure is ${ensure}")
			}

			if $source {
				file { "/var/lib/service/${name}/check":
					source  => $source,
					require => File["/var/lib/service/${name}"];
				}
			}
			if $content {
				file { "/var/lib/service/${name}/check":
					content => $content,
					require => File["/var/lib/service/${name}"];
				}
			}
		}
		absent: {
			file { "/var/lib/service/${name}/check":
				ensure => absent;
			}
		}
		default: { fail("Invalid value for ensure: ${ensure}") }
	}
}
