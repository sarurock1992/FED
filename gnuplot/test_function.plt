mu = 0
sigma = 1

set nokey
set notics

set xr[-2:2]
#set xr[0:2*mu]
set yr[0:0.23]
set size ratio 0.4 1

#f(x) = exp(-((x-mu)**2))/(2*(sigma**2))
f(x) = (1/sqrt(2*pi*sigma))*exp(-((x-mu)**2))/(2*(sigma**2))
f1(x) = -(x-mu)/(sigma**2)*f(x)
f2(x) = (((x-mu)**2)-(sigma**2))/(sigma**4)*f(x)
f3(x) = 2*(x-mu)/(sigma**4)*f(x)+(((x-mu)**2)-(sigma**2))/(sigma**4)*f1(x)
f4(x) = 2/(sigma**4)*f(x)+4*(x-mu)/(sigma**4)*f1(x)+(((x-mu)**2)-(sigma**2))/(sigma**4)*f2(x)

plot f(x) w steps
pause -1

set terminal svg
set output 'testfunction.svg'
replot

#set ter post enhanced "Times" 18
# set terminal tgif
# set output "testfunction.obj"
# replot

#set term png
#set output "phid2.png"
#replot
#set term x11

set table "testfunction.csv"
set samples 1000
plot f(x)
unset table

