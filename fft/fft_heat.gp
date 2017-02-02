set datafile separator ','

#set xrange[1000:3000]
set yrange[0:15]
#set y2range[-5:5]

set label font "Times New Roman"
set terminal x11
set y2tics

set tics nomirror

set pm3d
set pm3d map
set ticslevel 0

#set xlabel " time[ms] "
#set ylabel "Frequency by FFT [Hz] "
#set y2label " Target signal "

#const=0
const1=10
set isosample 1000
set cbrange[0:1500]
set palette defined ( 0 "blue", 750 "yellow", 1500 "red")
splot "fft_heat.dat" u ($1/100):2:3 with pm3d

#plot "fft_log.dat" u 1:3 w steps lc rgb "green" t "Target signal" axes x1y2,\
#     "fft_log.dat" u 1:2 w steps lc rgb "red" t "Frequency by FFT",\
#     const1
pause -1

set terminal eps
set output 'fft_heat.eps'
replot
