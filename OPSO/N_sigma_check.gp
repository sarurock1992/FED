#粒子群最適化のgifアニメ

#set xrange [0:0.4]
#set yrange [21:100]
#set y2range [0:0.015]

set xlabel font "Times New Roman, 25"
set ylabel font "Times New Roman, 25"
set y2label font "Times New Roman, 25"
set key font "Times New Roman, 15"

set tics font "Times New Roman, 15"
set terminal x11
set y2tics
set ytics nomirror
set xlabel 't'
#set nokey
set size ratio 0.5 1

set ylabel "N"

set y2label "sigma"


plot "errorcheck.dat" u ($1*0.001):2 w steps lw 1.5 lc rgb "red" t "N",\
     "errorcheck.dat" u ($1*0.001):3 w steps lw 1.5 lc rgb "blue" t "sigma"axes x1y2


pause -1 "hit"

set terminal svg
set output 'OPSO_N_sigma.svg'
replot

# set term png
# set output "PSO_check.png"
# replot
# set term x11
