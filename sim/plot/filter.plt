set terminal X11 noenhanced
set title "3rd-order Butterworth low-pass filter; fc=5kHz"
set key bottom left
set xlabel "f [Hz]"
set ylabel "Gain [dB]"
set y2label "Phase [°]"
set grid x y my
set logscale x
set xrange [1e+00:1e+05]
set xrange [1.000000e+01:2.000000e+04]
set mxtics 10
set grid mxtics
unset logscale y 
set yrange [-45:5]
set y2range [-225:25]
#set xtics 1
#set x2tics 1
set mytics 3
set y2tics 50
set format y "%g"
set format x "%g"
plot 'filter_a.data' using 1:2 with lines lw 2 title "Amplitude",\
     'filter_p.data' using 1:2 axes x1y2 with lines lw 2 title "Phase"
set terminal push
set terminal png noenhanced
set out 'filter.png'
replot
set term pop
replot
