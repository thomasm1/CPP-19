echo "Enter file name to append"
read fileName
if [ -f "$fileName" ]
then 
	#while IFS="" read -r line
	while IFS= read -r line
	do
		echo "$line"
	done < $fileName
else
	echo "$fileName does not exist"
fi
