Ts=0:0.001:0.001*1000

pi=3.141592
N=21
mu=N*Ts/2
sig=((N-20)/2+20)*Ts/16

sig2 = power(sig,2)
sig4 = power(sig,4)
Tsmu2 = power(Ts-mu,2)

y = ((Tsmu2)-sig2)/sig4/sqrt(2*pi*sig2)*exp(-1*Tsmu2/sig2)

plot(Ts,y,'r*');
