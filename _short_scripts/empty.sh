#!/bin/sh
# empty
if [ -s $1 ]
then
echo "The file $1 has contents."
exit 0
else
echo "The file $1 is absent or empty."
exit 1
fi
	unix[40] empty text
	The file text has contents.
	unix[41] empty xxxx
	The file xxxx is absent or empty.
	unix[42] echo $?
	1
	unix[43]