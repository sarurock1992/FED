##############################
#%%BoundingBox: 60 80 482 332
##############################
set datafile separator ','

set xrange [0:6]
#set xrange [0:2]
#set yrange [-1:1.5]
#set yrange [-5000000:5000000]

#set format y "%1.0t{/Symbol \264}10^{%L}"	
#set format x "%2.1f"
#set format y "%2.1f"
#set format y2 "%4.3f"
#set format y2 "%2.1f"

set ytics nomirror
set tics font "Times New Roman,31"

set xlabel font 'Times,31'
set ylabel font 'Times,31'

set xlabel 'Time [s]' offset 0,-3
#set ylabel 'x_n' offset -4,0

set y2label font 'Times,31'
set y2label 'Estimation Error [rad]' offset 5,0
set y2tics
set y2range [-0.04:0.04]
#set y2range [0:3]
#set y2range [0:12]



#set offsets 0,0,2,0
set size ratio 0.6 1.2

set rmargin 15
#set bmargin -5
set lmargin 15
#set tmargin -5

#set key at 0.9,77
set key spacing 2.7
set key font 'Times,24'
set key right t

set style line 1 lt 3 lw 5 lc 9

set terminal postscript enhanced eps
set output "check.eps"

plot "check.dat" using ($1/100):2 with steps lt 1 lw 1 t "sum1",\
"" using ($1/100):3 with steps lt 1 lw 3 lc 3 t "sum2",\
"" using ($1/100):($6-1.570796) with steps lt 1 lw 3 lc 1 t "Estimation Error"axes x1y2,\
1.57 linestyle 1 t "True Value" axes x1y2

