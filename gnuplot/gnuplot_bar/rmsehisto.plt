####################################
set format y "%3.2f"
set noxtics 
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
set output "rmseratiobar.eps"
####################################

set style data histogram
set style histogram clustered gap 3
set style fill solid border

plot 'rmseratiodata.dat' using 2:xtic(1) lc 1 title col, \
        '' using 3:xtic(1) lc 2 title col, \
        '' using 4:xtic(1) lc 3 title col
