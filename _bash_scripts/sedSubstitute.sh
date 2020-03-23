#! /bin/bash
set -x 
echo "Enter filename to substitute using sed"
read fileName

echo "Enter numeric to substitute using sed"
read numer

echo "Enter new number to substitute using sed"
read newnum

set -x
if [[ -f $fileName ]]
then
	sed -i 's/'$numer'/'$newnum'/g' $fileName #sub "numer" for 8000, case ins, globally
else
	echo "$fileName does not exist"
fi
