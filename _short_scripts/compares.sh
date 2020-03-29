#!/bin/sh
# compares
echo "true yields 0, false yields 1"
x="005"
[ "$x" = "005" ]
echo "Are strings 005 and 005 equal? $?"
[ "$x" = "5" ]
echo "Are strings 005 and 5 equal? $?"
[ $x -eq 005 ]
echo "Are integers 005 and 005 equal? $?"
[ $x -eq 5 ]
echo "Are integers 005 and 5 equal? $?"
exit 0	
	unix[38] compares
	true yields 0, false yields 1
	Are strings 005 and 005 equal? 0
	Are strings 005 and 5 equal? 1
	Are integers 005 and 005 equal? 0
	Are integers 005 and 5 equal? 0
	unix[39]
	


