#粒子群最適化のgifアニメ

set xrange [0:100]
set yrange [0:100]

set xlabel font "Times New Roman, 25"
set ylabel font "Times New Roman, 25"

set tics font "Times New Roman, 20"
set terminal x11
#set y2tics
#set ytics nomirror
set xlabel " r "
set nokey

set ylabel "N"

#set y2label "sigma"


plot "errorcheck.dat" u 1:2 w steps lw 3 lc rgb "red" t "N"

#pause -1 "hit"

set terminal svg
set output 'PSO_N.svg'
replot

# set term png
# set output "PSO_check.png"
# replot
# set term x11
