#####sum1,sum2,推定値，真値，（振動データ）プロット#######

set datafile separator ','

set xrange [0:20]
#set yrange [5.1:12]
#set y2range [1.54:1.6]
  
set xlabel font 'Times,31'
set ylabel font 'Times,31'
set xlabel 'Time [s]' offset 0,-3
set ylabel 'Angular verocity[dps]' offset -6,0
#set format y "%2.0t{/Symbol \264}10^{%L}"	

set tics font "Times New Roman,31"

#set format x "%2.1f"
#set format y2 "%4.3f"
#set format y "%4.3f"

#set ytics nomirror

#set y2tics
#set y2label font 'Times,31'
#set y2label 'Estimation Value [rad]' offset 5,0
set ylabel 'Estimation Value [rad]' offset -5,0

#set ytics 2000000

#set rmargin 15
#set lmargin 18

#set size 1.6,0.8
#set size 1.2,0.9
#set size 1.8,0.9

set key spacing 1.7
set key font 'Times,23'
set key r t
set key opaque box lc rgb "white" height 1
#set nokey
#set notics

#set terminal postscript enhanced eps
#set output "1000.eps"

plot "1000.csv" u ($1/50):2 w steps lc 3 lt 1 lw 3 t 'Target Signal'
pause -1
#plot "check50.dat" u ($1/50):6 w steps lc 1 lt 1 lw 3 t 'Estimation Value',\
#6.75 lw 5 lc 9 t "True Value"
#"" u ($1/50):2 w steps lc 0 lt 1 lw 3 t '-' ,\
#"" u ($1/50):3 w steps lc 4 lt 1 lw 3 t '-',\


