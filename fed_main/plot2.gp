

#set xrange[-5:5]
#set yrange[0:10]
#set y2range[-5:5]

set label font "Times New Roman"
set terminal x11
set y2tics

set tics nomirror

set xlabel " time[ms] "
set ylabel "Frequency by DFE [Hz] "
set y2label " Target signal " 



plot "dfe.csv" u 1:3 w steps lc rgb "green" t "Target signal" axes x1y2 ,\
     "dfe.csv" u 1:2 w steps lc rgb "red" t "Frequency by DFE",\
     "fft_log.csv" u 1:2 w steps lc rgb "blue" t "Frequency by FFT"
pause -1

set terminal png
set output 'dfe_fft.png'
replot
