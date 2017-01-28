set datafile separator ','
set yrange [0:100]
set xrange [60:80]
#set y2range [-1.5:1.5]

set terminal x11 
set y2tics
set ytics nomirror

set xlabel " Time[s] "
set ylabel " Estimated frequency[Hz] "
set y2label " Target signal " 
set nokey

const = 10

plot "fed.dat" u ($1/1000):2 w steps lc rgb "forest-green" t " Target signal " axes x1y2,\
     "fed.dat" u ($1/1000):3 w steps lc 1 t " Estimated Frequency [Hz] "

pause -1 "hit"

set terminal png
set output 'fed.png'
replot


