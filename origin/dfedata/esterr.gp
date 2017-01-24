set datafile separator ','


set xrange [0:6]
set yrange [-1.5:1.5]
set y2range [0:3]
set format x "%2.1f"
set format y2 "%2.1f"

set ytics nomirror
set y2tics
set tics font "Times New Roman,26"

set xlabel font 'Times,28'
set ylabel font 'Times,28'
set y2label font 'Times,28'
set xlabel 'Time [s]' offset 0,-3
set y2label 'Angular Velocity [dps]' offset 5,0
set ylabel 'Estimation Error [rad]' offset -5,0

#set offsets 0,0,2,0
set size ratio 0.45 1.6
set size 1.2,0.9

set rmargin 16
set bmargin 2
set lmargin 15
set tmargin -6

#set key at 0.32,7
set key spacing 1.7
set key font 'Times,20'
set key right top

#set style line 1 lw 5 lc 1

#set terminal pdf
#set output ".pdf"
set terminal postscript enhanced eps
set output "esterr.eps"

plot 'err1.dat' using ($1/100):2 with steps lc 3 lt 1 lw 1 t 'Target Signal',\
'dfesin.dat' using ($1/100):2 with steps lt 1 lw 1 lc 1 t 'Estimation Value' axes x1y2 

