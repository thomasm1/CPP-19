#!/bin/sh
# adder
sum=0
for x in $@
do
sum=‘expr $sum + $x‘
done
echo "The sum is $sum."
exit 0
	unix[44] adder 1 2 3 4 5
	The sum is 15.
	unix[45]


