set datafile separator ','
#set yrange [0:50]
#set xrange [0:3]
#set y2range [-1.5:1.5]

set terminal x11 
set y2tics
set ytics nomirror

set xlabel " Time[s] "
set ylabel " Estimated frequency[Hz] "
set y2label " numerator & denominator " 
set nokey

#const = 0

plot "dfe.dat" u ($1/1000):3 w steps lc 1 t " Estimated Frequency [Hz] ",\
     "dfe.dat" u ($1/1000):4 w steps lc 2 t " numerator " axes x1y2,\
     "dfe.dat" u ($1/1000):5 w steps lc 3 t " denominator " axes x1y2

pause -1 "hit"

set terminal png
set output 'check.png'
replot


