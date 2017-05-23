#! /usr/bin/gnuplot

base_name = "fig100"
eps_file = base_name . ".eps"
dat_file = base_name . ".dat"
set term postscript eps enhanced color solid
set output eps_file
set view 60,110,1,1
set xrange [500 : 1000]
set yrange [1 : 32]
set zrange [0 : 0.05]
set hidden3d

splot dat_file using 1:2:3 with lines

