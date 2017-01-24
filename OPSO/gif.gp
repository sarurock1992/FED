#粒子群最適化のgifアニメ

set xrange [0:200]
set yrange [0:0.015]
set zrange [0:5000]

set xlabel font "Times New Roman"
set terminal x11 

set xlabel " N "
set ylabel " sigma "
set zlabel " value " 
set format y "         %g"

set ytics 0, 0.005, 0.015
set mytics 0.001
set tics font "Times New Roman, 15"
set nokey
set size ratio 0.4 1

set term gif animate delay 4 optimize
set output 'OPSO.gif'

do for [i=0:999]{	
splot "check.dat" index i using 2:3:4 w p pt 7 ps 0.5 lc rgb "blue",\
      "check.dat" index i using 5:6:7 w p pt 7 ps 1.5 lc rgb "red"	
i=i+1
}
