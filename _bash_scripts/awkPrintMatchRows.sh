#! /bin/bash
echo "Enter filename to print from awk (1st 2 cols)"
read fileName

echo "Enter word found in row to print"
read wordSearch

if [[ -f $fileName ]]
then 	
	awk '/'$wordSearch'/ {print $1,$2}' $fileName
	else 
	echo "$fileName does not exist"
fi
