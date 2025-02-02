set datafile separator ','
#set yrange [0:100]
#set xrange [0:20]
#set y2range [-1.5:1.5]

set terminal x11 
set y2tics
set ytics nomirror

set xlabel " Time[s] "
set ylabel " Estimated frequency[Hz] "
set y2label " Target signal " 
set nokey

const = 10

plot "fed.dat" u ($1/100):2 w steps lc rgb "forest-green" t " Target signal " axes x1y2,\
     "fed.dat" u ($1/100):4 w steps lt 1 lc rgb "black" t "SimpleMovingAverage",\
     const

pause -1 "hit"

set terminal eps
set output 'fed.eps'
replot


