set datafile separator ","
set xdata time
set timefmt '%Y-%m-%d %H:%M:%S'
set format x "%d-%m\n%H:%M"
set xlabel "Time"
set ylabel "Sequence Number"
set grid
#set style data linespoints
set title "How frequently the ledger sequence is incremented over time"
set format y "%.0f"
set set boxwidth 100
set style fill solid

plot 'File_name.csv' using 1:2 with boxes title "Rippled", 'File_name.csv' using 1:2:2 with labels
