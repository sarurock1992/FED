set datafile separator ','
#set xrange[0:1]
#set yrange[-50:50]
#set y2range[-50:50]

set label font "Times New Roman"
set y2tics
set tics nomirror

set xlabel " Time[s] "
set ylabel "Estimated frequency [Hz] "
set y2label " Target signal " 

plot "fed.dat" u ($1/1000):2 w steps lt 1 lc rgb "green" t "Target signal" axes x1y2 ,\
     "fed.dat" u ($1/1000):3 w steps lt 1 lc rgb "red" t "FED",\
     "fft_log.dat" u ($1/1000):2 w steps lt 1 lc rgb "blue" t "FFT"

#set terminal png "Times" 18
#set output 'fed_fft.png'
#replot

#set ter post enhanced "Times" 18
#set terminal tgif
#set output "fed_fft.obj"
#replot

set format y2 "%2.1f"
set size 1.2,0.8
set lmargin 8
set rmargin 8
set tmargin 1.5
set bmargin 3.5
set terminal postscript eps enhanced color "Times" 18
set output "fed_fft.eps"
replot

set output
set terminal x11
