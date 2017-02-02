set datafile separator ','
#set yrange [0:3]
#set xrange [0.001:0.031]

set terminal x11 

#set xlabel " t "
#set ylabel " target signal " 

set xlabel font "Times New Roman, 25"
set ylabel font "Times New Roman, 25"

set tics font "Times New Roman, 15"
set terminal x11

#set notics
#set nokey
#set size ratio 0.5 1

plot "johnson.dat" u 1:2 w l
pause -1 "hit"

set terminal svg
set output 'gauss.svg'
replot

#set ter post enhanced "Times" 18
#set terminal tgif
#set output "coswave.obj"
#replot 



