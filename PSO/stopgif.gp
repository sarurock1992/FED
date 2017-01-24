#粒子群最適化のgifアニメ

set xrange [0:100]
set yrange [0:0.015]
set zrange [0:1e+5]
set xlabel font "Times New Roman, 20"
set ylabel font "Times New Roman, 20"
set zlabel font "Times New Roman, 20"
set tics font "Times New Roman, 20"
set terminal x11
set xlabel " N "
set ylabel " sigma "
set zlabel " value "
set nokey

splot "check.dat" index 10 using 2:3:4 w p pt 7 lc rgb "blue",\
      "check.dat" index 10 using 5:6:7 w p pt 7 ps 1 lc rgb "red"
#pause -1 "hit"

set terminal svg
set output 'PSO_10.svg'
replot

# set term png
# set output "PSO_check.png"
# replot
# set term x11
