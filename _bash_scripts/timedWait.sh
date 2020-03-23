#! /bin/bash
echo "press any key to continue"
while [ true ]
do
	read -t 3 -n 1  # time 3 secs; count- once
if [ $? = 0 ]
then 
	echo "okay, you've terminated this script, bye!"
	exit;
else 
	echo "...still waiting for you to press a key sir/madame..."
fi

done
