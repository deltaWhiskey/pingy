PINGY

Pingy is a script for isolating network problems. It it a tool for identifying
what part of a network is failing (connection to modem vs connection to ISP
vs problem somewhere on the internet.)

It was originally written to figure out whether an intermittent network
problem was between me and my modem, or between my modem and my ISP.

It works by pinging a list of IP addresses, and displaying periodic summaries
of whether the connection to that IP address is working.



To use this:

1) edit the pingy.conf file to include IP addresses that you want to monitor.
   IP addresses should be seperated by a space like "127.0.0.1 8.8.8.8"
2) Run the script with something like "bash pingy.sh"

At the end of every minute this script is running, if there were missed pings,
a line will be printed with summary information about each IP that failed to
respond. The line includes time stamp, IP address, and number of missed pings.

To log the output to a file, try something like:

bash pingy.sh | tee -a pingy.log

To stop pingy, hit control-c.
