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
		completions="$(ls /var/lib/service/)"
	fi

	if [ "${#words}" -lt 4 ]; then
		reply=("${(ps:\n:)completions}")
	fi
}
