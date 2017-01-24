#計測の推移のgifアニメ

set datafile separator ','
#set yrange [9.95:10.05]
set xrange [0:1000]
#set y2range [-1.5:1.5]
set terminal x11
set xlabel font "Times New Roman"
#set y2tics
set ytics nomirror
set xlabel " time[s] "
#set ylabel " Estimated Frequency[Hz] "
#set y2label "  " 
set nokey

set term gif animate delay 1 optimize
set output 'error.gif'

do for [i=0:1000]{
plot "dfe.dat" index 0:i u 1:2 w l lw 5 lc 15
i=i+1
}





