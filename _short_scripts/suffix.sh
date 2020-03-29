#! /bin/bash
# suffix
for fyle in *.$1
do
new=‘echo $fyle | sed -e"s/\.$1$/\.$2/"‘
mv $fyle $new
done
exit 0
	unix[49] ls *.f
	a.f b.f pgm.f xyz.w.f
	unix[50] suffix f for
	unix[51] ls *.for
	a.for b.for pgm.for xyz.w.for
	unix[52]
