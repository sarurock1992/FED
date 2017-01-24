#粒子群最適化のgifアニメ

#set xrange [0:500]
#set yrange [0:35]
set xlabel font "Times New Roman"
set terminal x11 
set xlabel " N "
set ylabel " sigma "
 
set nokey

set term gif animate delay 1 optimize
set output 'oPSO_dfe.gif'

do for [i=0:1000]{
plot "dfe.dat" index 0:i u 1:2 w l lw 10 lc rgb "red"
i=i+1
}


