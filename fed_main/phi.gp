set datafile separator ','
#set yrange [0:100]
#set xrange [0:20]
#set y2range [-1.5:1.5]

set terminal x11 
set y2tics
set ytics nomirror

set xlabel " Time[s] "
set ylabel " phi "
set y2label " phi_dd " 
set nokey

plot "phi.dat" u 1:2 w steps lc rgb "blue" t " phi " ,\
     "phi.dat" u 1:3 w steps lc rgb "red" t "phi_dd" axes x1y2

pause -1 "hit"

set terminal png
set output 'phi.png'
replot


