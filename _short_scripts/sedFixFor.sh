#! /bin/bash
# fixfor
for fyle in *.for
do
new=‘echo $fyle | sed -e"s/\.for$/\.f/"‘
mv $fyle $new
done
exit 0
	unix[46] ls *.for
	a.for b.for pgm.for xyz.w.for
	unix[47] fixfor
	unix[48] ls *.f
	a.f b.f pgm.f xyz.w.f