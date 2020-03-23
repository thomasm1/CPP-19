#! /bin/bash
echo "Enter file name to append"
read fileName
if [ -f "$fileName" ]
then 
	echo "Enter text to be appended"
	read fileText
	echo "$fileText" >> $fileName
else
	echo "$fileName does not exist"
fi
