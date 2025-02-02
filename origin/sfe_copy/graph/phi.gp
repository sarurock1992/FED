set datafile separator whitespace#','

pi=3.14159265
N=21
T=0.001
mu=N*T/2
sig=((N-20)/2+20)*T/16

set xrange [0:T*N]
#set yrange [0:35]
  
set xlabel font 'Times,31'
#set ylabel font 'Times,31'
#set xlabel 'Time [s]' offset 0,-3
#set ylabel '-' offset -5,0

#set format y "%2.0t{/Symbol \327}10^{%L}"
#set mxtics 5
#set tics font "Times New Roman,31"
#set format x "%3.2f"
set notics
set samples 1000
set table "phi.table"

set rmargin 15
set lmargin 15

set size 1.6,0.8
set nokey


plot 1/sqrt(2*pi*sig*sig)*exp(-(x-mu)**2/(2*sig**2))
plot "phi.table" u 1:2 w lines#with points pointtype 7 ps 2 lc 3



