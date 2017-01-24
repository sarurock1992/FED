#粒子群最適化のgifアニメ

#set xrange [9000:10000]
set yrange [-1.5:1.5]

set xlabel font "Times New Roman, 25"
set ylabel font "Times New Roman, 25"

set tics font "Times New Roman, 20"
set terminal x11
#set y2tics
#set ytics nomirror
#set nokey

set ylabel "signal"

#set y2label "sigma"

plot "signalerror.dat" u 1:4 w steps lw 0.5 lc rgb "forest-green" t "estimated",\
     "signalerror.dat" u 1:5 w steps lw 0.5 lc rgb "red" t "data"
pause -1 "hit"

set terminal svg
set output 'OPSO_signalerror.svg'
replot

# set term png
# set output "OPSO_check.png"
# replot
# set term x11
