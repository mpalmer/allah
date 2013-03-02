_allah() {
	COMPREPLY=()
	local word="${COMP_WORDS[COMP_CWORD]}"

	if [ "$COMP_CWORD" -eq 1 ]; then
		COMPREPLY=( $(compgen -W "start
restart
stop
monitor
unmonitor
remove
log
status
check
signal" -- "$word") )
	elif [ "$COMP_CWORD" -eq 2 ]; then
		local words=("${COMP_WORDS[@]}")
		unset words[0]
		unset words[$COMP_CWORD]
		if [ $UID -eq 0 ]; then
			local completions=$(ls /etc/service/)
		else
			local completions=$(sudo -l | grep allah | sed -r 's/^.+allah\s+\w+\s+//' | cut -d ' ' -f 1 | sort | uniq)
		fi
		COMPREPLY=( $(compgen -W "$completions" -- "$word") )
	fi

}

complete -F _allah allah
