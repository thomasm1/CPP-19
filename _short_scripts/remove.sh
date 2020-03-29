#! /bin/bash
# rem [ Exit Codes ] 
rm junk
echo "The return code from rm was $?"
exit 0
	unix[5] touch junk
	unix[6] rem
	The return code from rm was 0
	unix[7] rem
	rm: junk: No such file or directory
	The return code from rm was 2


