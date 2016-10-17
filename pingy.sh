#!/bin/bash

targets=""
config_file="pingy.conf"
base_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
logging_minute=`date +%M`
logging_minute_human=`date +"%Y-%m-%d %H:%M"`
logging_fails="?"

################################
# Functions

# Ping each target once.
# Log failures in logging_fails
pingAll ()
{
	local target
	for target in $targets;
	do

		# ping target
		ping -W 1 -c 1 ${target} &> /dev/null

		# update logging_fails
		if [ "$?" != "0" ]
		then
			logging_fails="${logging_fails}\n${target}"
		fi
	done
}

# If minute has changed since last call, report any ping failures
# and reset variables.
generateReport ()
{
	# Do some book keeping once per minute
	local current_minute=`date +%M`
	local target
	local count
	if [ "${current_minute}" != "${logging_minute}" ]
	then
		for target in $targets;
		do
			count=`printf ${logging_fails} | grep ${target} | wc -l`
			if [ "${count}" != "0" ]
			then
				echo ${logging_minute_human} ${target} ${count} fails
			fi
		done
		
		logging_minute=${current_minute}
		logging_minute_human=`date +"%Y-%m-%d %H:%M"`
		logging_fails="?"
	fi
}

# Load config file. Set global variable ${targets}
loadConfig ()
{
	local config_path="${base_dir}/${config_file}"
	echo "Loading config file: ${config_path}"
	if [ ! -f ${config_path} ]
	then
		echo "Could read load config file ${config_path}"
		exit 1
	fi
	targets=`cat ${config_path}`
}

#################################
# Main Loop

loadConfig
echo Pinging ${targets}
echo When a ping fails, will print summary lines up to once a minute with fail counts.

while [ 1 ]
do
	pingAll
	generateReport
	sleep 1
done
