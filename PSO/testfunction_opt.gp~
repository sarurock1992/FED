#粒子群最適化のgifアニメ

set xrange [0:66]
set yrange [0:6000]

set xlabel font "Times New Roman, 25"
set ylabel font "Times New Roman, 25"

set tics font "Times New Roman, 20"
set terminal x11
#set y2tics
#set ytics nomirror
set xlabel " k "
set nokey

set ylabel ""

#set y2label "sigma"

plot "testfunction_opt.csv" u 1:2 w steps lw 3 lc rgb "red"

pause -1 "hit"

set terminal svg
set output 'testfunction_opt.svg'
replot

# set term png
# set output "PSO_check.png"
# replot
# set term x11
