set terminal x11 
set ytics nomirror
set y2tics
set xrange [0:1000]
set xlabel "time " 
#set yrange [0:200]
set y2label "estimated frequency [sec/rad]" 
#set y2range [-50:50]
set y2label "Electroencephalogram" 
pi=3.141592
plot "./err.dat" u 1:2 w l axes x1y1, "" u 1:3 w l axes x1y1, "" u 1:4 w l axes x1y2
pause -1 "hit"
set terminal tgif
set output "ew.obj"
plot "./err.dat" u 1:2 w l axes x1y1, "" u 1:3 w l axes x1y1, "" u 1:4 w l axes x1y2