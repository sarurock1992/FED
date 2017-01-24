set xtics ("20" 0, "40" 1, "60" 2, "80" 3, "100" 4, "150" 5, "200" 6)

set format y "%3.2f"
set tics font "Times,20"
set key font 'Times,15'
set xlabel font 'Times,29'
set ylabel font 'Times,29'
set xlabel 'Num of sample' offset 0,-3
set ylabel 'RMSE' offset -4,0
set size ratio 0.75

set terminal postscript enhanced eps

set output "20-200rmse.eps"
plot "20hz.csv" w lp lw 3 pt 7 lc 4 t "20Hz", "40hz.csv" w lp lw 4 pt 7 lc 1 t "40Hz", "50hz.csv" w lp lw 4 pt 7 lc 11 t"50Hz", "100hz.csv" w lp lw 4 pt 7 lc 3 t "100Hz", "200hz.csv" w lp lw 4 pt 7 lc 0 t "200Hz"#, "500hz.csv" w lp lw 4 pt 7 t "500Hz", "1000hz.csv" w lp lw 4 pt 7 t "1000Hz"

q
