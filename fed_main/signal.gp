set datafile separator ','
#set yrange [0:50]
#set xrange [60:80]

set terminal x11 

set xlabel " Time[s] "
set ylabel " Target signal " 
set nokey

const = 0

plot "fed.dat" u ($1/1000):2 w steps lc rgb "forest-green" t " Target signal "

pause -1 "hit"

set terminal postscript eps enhanced color "Times" 18
set output "signal.eps"
replot

set output
set terminal x11

#set terminal png
#set output 'signal.png'
#replot


