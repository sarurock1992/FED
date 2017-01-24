#粒子群最適化のgifアニメ

set xrange [21:100]
set yrange [0:0.015]
set zrange [0:500]

set xlabel font "Times New Roman, 20"
set ylabel font "Times New Roman, 20"
set zlabel font "Times New Roman, 20"
set tics font "Times New Roman, 15"
set terminal x11
set xlabel " N "
set ylabel " sigma "
set zlabel " value "
set nokey
set size ratio 0.4 1

splot "check.dat" index 399 using 2:3:4 w p pt 7 ps 0.5 lc rgb "blue",\
      "check.dat" index 399 using 5:6:7 w p pt 7 ps 0.8 lc rgb "red"
#pause -1 "hit"

set terminal svg
set output 'OPSO_400.svg'
replot

# set term png
# set output "PSO_check.png"
# replot
# set term x11
