set datafile separator ','
set yrange [-1.5:1.5]
set xrange [0:0.3]

set nokey
set terminal x11 
#set y2tics
set ytics nomirror
set xlabel " time[s] " 
plot "sinmat10hz.csv" u ($1/1000):2 w l 
pause -1 "hit"

set terminal tgif
set output "wave.obj"
replot 
