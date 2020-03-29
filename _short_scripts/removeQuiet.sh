#! /bin/bash
# quiet [ Exit Codes ] 
rm junk 2> /dev/null
echo "The return code from rm was $?"
exit 0
	unix[8] touch junk
	unix[9] quiet
	The return code from rm was 0
	unix[10] quiet
	The return code from rm was 2