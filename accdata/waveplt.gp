set datafile separator ','

set xlabel 'time [s]'
#set ylabel 'Angular velocity [dps]'

set xrange [0:1]
set yrange [-1.5:1.5]

#set terminal postscript enhanced eps
#set output "sinmat.eps"
#set format x""
#set format y""
set nokey

plot "o2pi_1000hz.csv" u ($1*0.001):2 w steps lw 1 # t 'Target Signal'
pause -1

set term svg
set output 'target_signal.svg'
replot

#set term jpeg
#set output "test.jpg"
#replot
#set term x11
