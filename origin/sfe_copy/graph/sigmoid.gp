set xlabel font 'Times,31'
set ylabel font 'Times,31'
#set xlabel 'Time [s]' offset 0,-3
#set ylabel '-' offset -5,0

#set format y "%2.0t{/Symbol \327}10^{%L}"
#set mxtics 5
#set tics font "Times New Roman,31"
#set format x "%3.2f"
#set notics

set xrange [-5:5]
set xrange [-1.2:1.2]

#set rmargin 15
#set lmargin 15

#set size 1.6,0.8
#set nokey

set terminal postscript enhanced eps
set output "sigmoid.eps"

plot 1/(1+exp(-x))



