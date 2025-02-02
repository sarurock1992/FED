##--------------------------------
## This script for Ogata.
##--------------------------------

# グリッド線を描くかどうか
#set grid

# x軸の設定
set xtics ("20" 0, "40" 1, "60" 2, "80" 3, "100" 4, "150" 5, "200" 6, "300" 7, "400" 8, "500" 9)

#set format y "%.1f"
set tics font "Times,20"
set key font 'Times,17'
set xlabel font 'Times,29'
set ylabel font 'Times,29'
set xlabel 'Num of sample' offset 0,-3
set ylabel 'RMSE' offset -4,0
set size ratio 0.75
set rmargin 10
set bmargin 7
set lmargin 15

set terminal postscript enhanced eps

set output "20-1000rmse.eps"
plot "20hz.csv" w lp lw 3 pt 7 lc 0 t "20Hz",  "50hz.csv" w lp lw 4 pt 7 lc 1 t"50Hz", "100hz.csv" w lp lw 4 pt 7 lc 3 t "100Hz", "500hz.csv" w lp lw 4 pt 7 lc 11 t "500Hz", "1000hz.csv" w lp lw 4 pt 7 lc 13 t "1000Hz"

reset
