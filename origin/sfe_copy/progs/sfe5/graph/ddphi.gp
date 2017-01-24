
pi=3.14159265
N=21
T=0.01
mu=N*T/2
sig=((N-20)/2+20)*T/16

set xrange [0:T*N]
set yrange [-250000:100000]
  
set xlabel font 'Times,31'
#set ylabel font 'Times,31'
#set xlabel 'Time [s]' offset 0,-3
#set ylabel '-' offset -5,0
set tics font "Times New Roman,31"
set format x "%3.2f"

set ytics 100000

#set samples 1000
#set table "ddphi.table"

set format y "%2.1t{/Symbol \264}10^{%L}"			

set rmargin 15
#set bmargin 1
set lmargin 25
#set tmargin 1
#set offset 0,0,10,10

#set size ratio 0.45 1.6
#set size 1.2,0.9
set size 1.7,0.8
set nokey
set notics

set terminal postscript enhanced eps
set output "ddphi0.01.eps"

#plot (((x-mu)**2-sig**2)/sig**4*1/sqrt(2*pi*sig**2)*exp(-1*(x-mu)**2/sig**2))
plot "ddphi.table" u 1:2 w line # with points pointtype 7 ps 2 lc 3

