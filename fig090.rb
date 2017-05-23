#! /usr/bin/env ruby

require 'pp'
require 'gnuplot'
require 'pathname'
require "optparse"

USAGE = "Usage: #{File.basename("#{__FILE__}")} [options]"

## option analysis
options = {}
op = OptionParser.new
op.banner = USAGE
op.on("-e" , "--eps" , "Output eps format, alternative to png format"){options[:eps] = true}
op.parse!(ARGV)

dat_file = Pathname( __FILE__ ).sub_ext( ".dat").to_s
png_file = Pathname( __FILE__ ).sub_ext( ".png").to_s
eps_file = Pathname( __FILE__ ).sub_ext( ".eps").to_s

Gnuplot.open do |gp|
  Gnuplot::SPlot.new(gp) do |plot|
    if options[:eps]
      plot.terminal "postscript eps enhanced color solid"
      plot.output   Pathname( __FILE__).sub_ext( ".eps").to_s
    else
      plot.terminal "png enhanced font 'IPA P ゴシック' fontscale 1.2"
      plot.output   Pathname( __FILE__).sub_ext( ".png").to_s
    end

    #plot.title    "TODO"
    plot.xlabel   "y_1"
    plot.ylabel   "y_2"
    #plot.xrange    '[-66:-45]'
    #plot.yrange    '[-66:-45]'
    #plot.nokey
    #plot.set "size ratio 1"

    #plot.data << Gnuplot::DataSet.new("x") do |ds|
    #  ds.with      = "lines"
    #  ds.linecolor = "rgb 'blue' linetype 1"
    #  ds.linewidth = 1
    #end 

    lines = File.open(dat_file).readlines.select{|line| line !~ /^\s*\#/ }
    lines.map!{|i| i.strip.split(/  */).map{|i| i.to_f }}
    columns = lines.transpose
    1.upto(columns.size-1) do |i|
      #pp columns[0].size
      #pp columns[1].size
      #pp columns[2].size
      #plot.data << Gnuplot::DataSet.new([columns[0], columns[1], columns[2]]) do |ds|
      plot.data << Gnuplot::DataSet.new([columns[0], columns[1], columns[2]]) do |ds|
        plot.set "dgrid3d 50,50"
        plot.set "hidden3d"
        plot.xrange "[0:5]"
        plot.yrange "[0:5]"
        plot.zrange "[0:3]"
        plot.set 'pm3d' #色つき
        #plot.set 'isosamples 50,50'
        #plot.set 'lines'

        #ds.with = 'lines pm3d'
      end
    end
  end
end

