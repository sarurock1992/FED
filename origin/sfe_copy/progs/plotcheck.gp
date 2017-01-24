set terminal x11 
set sample 1000000
set xrange [0:1000]
#set yrange [-1.1:1.1]
set xlabel "time  [0.01 s]" 
set ylabel "angle [rad]" 
pi=3.141592
plot "./check.dat" u 1:2 w l, "./check.dat" u 1:3 w l, "./check.dat" u 1:($4/100) w l, "./check.dat" u 1:($5/1000) w l
#plot "./check.dat" u 1:2 w l, "./check.dat" u 1:3 w l, "./check.dat" u 1:($4/100) w l, "./check.dat" u 1:($5/1000) w l
#plot "./check.dat" u 1:2 w l, "./check.dat" u 1:3 w l, sin(0.5*pi*x)
pause -1 "hit"
set terminal tgif
set output "check.obj"
plot "./check.dat" u 1:2 w l, "./check.dat" u 1:3 w l, "./check.dat" u 1:4 w l