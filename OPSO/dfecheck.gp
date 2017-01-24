#粒子群最適化のgifアニメ

set xrange [0:100]
set yrange [0:20]

set xlabel font "Times New Roman, 25"
set ylabel font "Times New Roman, 25"

set tics font "Times New Roman, 20"
set terminal x11
#set y2tics
#set ytics nomirror
set xlabel " k "
set nokey
set size ratio 0.4 1

set ylabel "dfe"
#set ylabel "N"
#set ylabel "sigma"
#set ylabel "value"
#set ylabel "error[%]"
#set y2label "sigma"

plot "errorcheck.dat" u 1:2 w steps lw 3 lc rgb "black" t "N"
pause -1 "hit"

set terminal svg
set output 'OPSO_dfe.svg'
replot

# set term png
# set output "oPSO_check.png"
# replot
# set term x11
