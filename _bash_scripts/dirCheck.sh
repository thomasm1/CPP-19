#! /bin/bash
echo "Enter directory name"
read direct
if [ -d "$direct" ]
then 
	echo "$direct exists"
else
	echo "$direct does not exist"
fi
