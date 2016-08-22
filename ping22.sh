# ping22 is a utility built to "ping" a host on a specific port and let you know 
# if it is open, closed, or filtered down every second. This is convenient if you
# are waiting for a host to restart a service and ping won't tell you if it's up.
# 
# Author: Taylor Park
# Version: 0.1 
# Date: 8/21/16

# TO DO LIST
# Add a feature to sanity check inputs
# Add a help screen etc.
# Add an interval option
# Add the latency to the output

RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
NC='\033[0m'

PORT=$2
if [ -z $2 ]
	then
		PORT="22"
fi


echo -e Pinging $1 on port $PORT

while sleep 1; do 
	{
		MSG="$(date | cut -d' ' -f 4) - $1 is"
		status="$(nmap -Pn -p $PORT $1 | grep tcp | cut -d' ' -f2)"

		case $status in
			open )
				MSG="$MSG ${GREEN}open${NC}";;
			closed ) 
				MSG="$MSG ${RED}closed${NC}";;
			filtered )
				MSG="$MSG ${ORANGE}filtered${NC}";;
			"" )
				break 2;;
		esac
	
		MSG="$MSG on port $PORT" 
	} 
	echo -e $MSG
done

