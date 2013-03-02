if [[ ! -o interactive ]]; then
	return
fi

compctl -K _allah allah

_allah() {
	local words completions
	read -cA words

	if [ "${#words}" -eq 2 ]; then
		completions="start
restart
stop
monitor
unmonitor
remove
log
status
check
signal"
	elif [ "${#words}" -eq 3 ]; then
		if [ $UID -eq 0 ]; then
			completions="$(ls /var/lib/service/)"
		else
			completions=$(sudo -l | grep allah | sed -r 's/^.+allah\s+\w+\s+//' | cut -d ' ' -f 1 | sort | uniq)
		fi
	fi

	if [ "${#words}" -lt 4 ]; then
		reply=("${(ps:\n:)completions}")
	fi
}
