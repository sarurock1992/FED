#粒子群最適化のgifアニメ

set xrange [0:100]
set yrange [0:0.015]

set xlabel font "Times New Roman, 25"
set ylabel font "Times New Roman, 25"

set tics font "Times New Roman, 20"
set terminal x11
#set y2tics
#set ytics nomirror
set xlabel " r "
set nokey

set ylabel "error[%]"
#set y2label "sigma"

plot "errorcheck.dat" u 1:5 w steps lw 3 lc rgb "black"
#pause -1 "hit"

set terminal svg
set output 'PSO_error.svg'
replot

# set term png
# set output "PSO_check.png"
# replot
# set term x11
