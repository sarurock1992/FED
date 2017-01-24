
set xrange [0:1000]
set samples 250
set xlabel "time"
set ylabel "Location"
set title "test of gnuplot script - oscillation"

set table "sin.table"

plot sin(x/50)

unset table

plot sin(x/50) with steps
pause -1
