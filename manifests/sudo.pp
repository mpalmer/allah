define allah::sudo($service,
                   $user,
                   $host              = undef,
                   $ensure            = "present",
                   $god_compatibility = undef,
                   $passwd            = undef) {
	$allah_bin = "/usr/local/bin/allah"
	$god_bin   = "/usr/local/bin/god" 

	Sudo::Entry {
		ensure => $ensure,
		user   => $user,
		host   => $host,
		passwd => $passwd,
	}
	sudo::entry {
		"allah/sudo/${name}/${service}/${user}/start":     command => "${allah_bin} start ${service}";
		"allah/sudo/${name}/${service}/${user}/restart":   command => "${allah_bin} restart ${service}";
		"allah/sudo/${name}/${service}/${user}/stop":      command => "${allah_bin} stop ${service}";
		"allah/sudo/${name}/${service}/${user}/monitor":   command => "${allah_bin} monitor ${service}";
		"allah/sudo/${name}/${service}/${user}/unmonitor": command => "${allah_bin} unmonitor ${service}";
		"allah/sudo/${name}/${service}/${user}/log":       command => "${allah_bin} log ${service}";
		"allah/sudo/${name}/${service}/${user}/status":    command => "${allah_bin} status ${service}";
		"allah/sudo/${name}/${service}/${user}/signal":    command => "${allah_bin} signal ${service} *";
	}

	if $service == "*" {
		sudo::entry {
			"allah/sudo/${name}/*/${user}/status/any": command => "${allah_bin} status";
			"allah/sudo/${name}/*/${user}/quit":       command => "${allah_bin} quit";
			"allah/sudo/${name}/*/${user}/terminate":  command => "${allah_bin} terminate";
		}
	}

	if $god_compatibility {
		sudo::entry {
			"god/sudo/${name}/${service}/${user}/start":     command => "${god_bin} start ${service}";
			"god/sudo/${name}/${service}/${user}/restart":   command => "${god_bin} restart ${service}";
			"god/sudo/${name}/${service}/${user}/stop":      command => "${god_bin} stop ${service}";
			"god/sudo/${name}/${service}/${user}/monitor":   command => "${god_bin} monitor ${service}";
			"god/sudo/${name}/${service}/${user}/unmonitor": command => "${god_bin} unmonitor ${service}";
			"god/sudo/${name}/${service}/${user}/log":       command => "${god_bin} log ${service}";
			"god/sudo/${name}/${service}/${user}/status":    command => "${god_bin} status ${service}";
			"god/sudo/${name}/${service}/${user}/signal":    command => "${god_bin} signal ${service} *";
		}

		if $service == "*" {
			sudo::entry {
				"god/sudo/${name}/*/${user}/status/any": command => "${god_bin} status";
				"god/sudo/${name}/*/${user}/quit":       command => "${god_bin} quit";
				"god/sudo/${name}/*/${user}/terminate":  command => "${god_bin} terminate";
			}
		}
	}
}
