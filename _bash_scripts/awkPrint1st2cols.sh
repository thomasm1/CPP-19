#! /bin/bash
echo "Enter filename to print from awk (1st 2 cols)"
read fileName

if [[ -f $fileName ]]
then 	
	# awk  '{print}' $fileName
	awk '{print $1,$2}' $fileName
	else 
	echo "$fileName does not exist"
fi
