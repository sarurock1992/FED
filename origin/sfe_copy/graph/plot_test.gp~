set datafile separator ','
#set yrange [9.95:10.05]
set xrange [0:0.001*21]
#set y2range [-9:9]

set terminal x11 
set y2tics
set ytics nomirror
set xlabel " time[s] "
set ylabel " phi "
set y2label " phidd " 

plot "phi_phidd.dat" u ($1/10):3 w l t " phi ",\
     "phi_phidd.dat" u ($1/10):2 w l t " phidd " axes x1y2,\
     "phi_phidd.dat" u ($1/10):4 w l t "" axes x1y1,\
     "phi_phidd.dat" u ($1/10):5 w points pt 7 t "" axes x1y2,\
     "phi_phidd.dat" u ($1/10):6 w points pt 7 t ""  
#     "phi_phidd.dat" u 1:3 w steps t " " axes x1y2;
pause -1 "hit"


set ter post enhanced "Times" 18
set terminal tgif
set output "phi-phidd.obj"
replot



