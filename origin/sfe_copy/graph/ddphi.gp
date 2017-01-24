
pi=3.141592
N=21
T=0.001
mu=N*T/2
sig=((N-20)/2+20)*T/16

#set xrange [0:T*N]
#set yrange [-250000:100000]
  
set xlabel font 'Times,31'
set format y "%2.1t{/Symbol \264}10^{%L}"			

set nokey
set notics

plot (((x-mu)**2-sig**2)/sig**4*1/sqrt(2*pi*sig**2)*exp(-1*(x-mu)**2/sig**2))
pause -1 "hit"

#set ter post enhanced "Times" 18
#set terminal tgif
#set output "ddphi.obj"
#replot 

