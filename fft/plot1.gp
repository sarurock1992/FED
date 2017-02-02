set datafile separator ','

#set xrange[-5:5]
#set yrange[0:100]
#set y2range[-5:5]

set label font "Times New Roman"
set terminal x11
set y2tics

set tics nomirror

set xlabel " time[s] "
set ylabel "Frequency by FFT [Hz] "
set y2label " Target signal "

#const=0
const1=10

plot "fft_log.dat" u ($1/100):3 w steps lc rgb "green" t "Target signal" axes x1y2,\
     "fft_log.dat" u ($1/100):2 w steps lc rgb "red" t "Frequency by FFT",\
     const1
pause -1

set terminal eps
set output 'fft.eps'
replot
