#粒子群最適化のgifアニメ

set xrange [0:100]
set yrange [0:0.0125]
set zrange [0:1e+5]
set xlabel font "Times New Roman"
set terminal x11
set xlabel " N "
set ylabel " sigma "
set zlabel " value "
set nokey

set term gif animate delay 5 optimize
set output 'PSO.gif'

do for [i=0:100]{
splot "check.dat" index i using 2:3:4 w p pt 7 lc rgb "blue",\
      "check.dat" index i using 5:6:7 w p pt 7 ps 2 lc rgb "red"
i=i+1
}

