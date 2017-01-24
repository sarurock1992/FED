set terminal x11 
set samples 1000
set xrange [0:0.2]
#set yrange [0:4.5]
set xlabel "time  [s]" 
set ylabel "angle [rad]" 
pi=3.14159265
N=20
T=0.01
mu=N*T/2
sig=((N-20)/2+20)*T/16
plot 1/sqrt(2*pi*sig*sig)*exp(-(x-mu)**2/(2*sig**2))
replot "datp.dat" pt 7 ps 2
#plot sin(0.5*pi*x+1075) 
pause -1 "hit"
set terminal tgif
set output "phi.obj"
plot 1/sqrt(2*pi*sig*sig)*exp(-(x-mu)**2/(2*sig**2))
#plot sin(2*pi*x+1075)
replot "datp.dat" pt 7 ps 2