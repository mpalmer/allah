# Create a per-user daemontools tree.
#
# The idea here is to allow a user to create their own daemontools-managed
# services by the same mechanism as you would for the system-level
# `/service` directory, but where all processes, files, etc are run as, and
# created by, the user in question.  This is done by running a system-level
# daemontools service, `svscan-<user>`, which just runs `svstat` as the
# user, on a directory which the user has access to.
#
# Attributes:
#
#  * `user` (**namevar**; string)
#
#     The user to create the service tree for.  This also has an impact on
#     the system-level daemontools service
#
#  * `directory` (string; optional; default `$HOME/service`)
#
#     Where `svstat` will scan looking for service directories.  This
#     directory is not created by us, we merely point `svstat` in its
#     direction.
#
define allah::user(
		$directory = undef,
) {
	$homedir = homedir($name)

	if $directory == undef {
		$svdir = "${homedir}/service"
	} else {
		$svdir = $directory
	}

	daemontools::service { "svscan-${name}":
		user                 => $name,
		command              => "/usr/bin/svscan ${svdir}",
		use_secondary_groups => true,
		sudo_control         => "allah",
		allah_group          => "svscan",
	}
}
		
