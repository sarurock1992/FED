set datafile separator ','
set yrange [-10:10]
#set xrange [200:300]

set terminal x11 
set y2tics
set ytics nomirror
set xlabel "time " 
plot "check.dat" u 1:2 w l t "target signal", "" u 1:3 w l t "sum1","" u 1:4 w l t "sum2","" u 1:7 w l t "omega" axes x1y2
pause -1 "hit"
set terminal tgif
set output "check.obj"
plot "check.dat" "" u 1:2 w l t "target signal", "" u 1:3 w l t "sum1", "" u 1:4 w l t "sum2","" u 1:7 w l t "omega"
