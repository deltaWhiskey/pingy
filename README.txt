PINGY

Pingy is a script for monitoring network reliability. It was originally written
to help isolate a network problem; was the problem within my local network, or
was the problem in my ISP's network?

To use this:

1) edit the "targets" variable at the top of pingy.sh to indicate what
   IP addresses you want to monitor your connectivity to.
2) Run the script with something like "bash pingy.sh"

At the end of every minute this script is running, if there were missed pings,
a line will be printed with summary information about each IP that failed to
respond. The line includes time stamp, IP address, and number of missed pings.

To log the output to a file, try something like:

bash pingy.sh | tee pingy.log

To stop pingy, hit control-c.
