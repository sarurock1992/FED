set datafile separator ','
#set yrange [9.95:10.05]
set xrange [0:66]
#set y2range [-1.5:1.5]

set xlabel font "Times New Roman, 25"
set ylabel font "Times New Roman, 25"

set tics font "Times New Roman, 20"
set terminal x11
#set y2tics
#set ytics nomirror
set xlabel " k "
set nokey

set ylabel ""

set nokey
plot "phi_phidd.dat" u 1:2 w steps lc rgb "red" t " phi "
#plot "phi_phidd.dat" u 1:3 w steps lc rgb "forest-green" t " phidd "
pause -1 "hit"

set terminal svg
set output 'testfunction_opt.svg'
replot

# set term png
# set output "phi.png"
# replot
# set term x11

#set ter post enhanced "Times" 18
#set terminal tgif
#set output "signalcheck.obj"
#replot 



