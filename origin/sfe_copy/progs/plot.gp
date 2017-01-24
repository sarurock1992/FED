set terminal x11 
set xrange [0:1000]
set yrange [-1.1:1.1]
set xlabel "time  [0.01 s]" 
set ylabel "angle [rad]" 
pi=3.141592
plot "./err.dat" u 1:2 w l, "./err.dat" u 1:3 w l
pause -1 "hit"
set terminal tgif
set output "phi.obj"
plot "./err.dat" u 1:2 w l, "./err.dat" u 1:3 w l