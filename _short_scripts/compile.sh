#!/bin/sh
# compile
if [ "$SRCDIR" = "" ]
then
echo "using default source directory"
SRCDIR=$HOME/src
else
echo "using source directory $SRCDIR"
fi
g77 $SRCDIR/$1
exit $?
	unix[27] export SRCDIR=‘pwd‘
	unix[28] compile hello.f
	using source directory /home/mike/Classes/shell
	unix[29] echo $?
	0
	unix[30] a.out
	hello
	unix[31] export SRCDIR=""
	unix[32] compile hello.f
	using default source directory
	g77: /home/mike/src/hello.f:
	No such file or directory
	unix[33] echo $?
	1
unix[34]

