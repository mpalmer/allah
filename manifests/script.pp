class allah::script {
	file {
		"/usr/local/bin/allah":
			source  => "puppet:///modules/allah/usr/local/bin/allah",
			mode    => "0555",
			links   => follow;
		"/etc/bash_completion.d/allah":
			source  => "puppet:///modules/allah/etc/bash_completion.d/allah",
			mode    => "0444",
			links   => follow;
	}
}
