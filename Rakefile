# coding: utf-8
# Rakefile for LaTeX documents.

# Copyright (c) 2017 Ippei KISHIDA
# Released under the MIT license
# http://opensource.org/licenses/mit-license.php
# Last-modified: 2017/05/23 20:56:30.

## USAGE:
## rake 
## rake dvi
## rake pdf
## rake png

require "pp"
require "fileutils"
require "pathname"
require "tempfile"
require "rake/clean"

IMAGEMAGICK = "convert"
INKSCAPE = "inkscape"
LATEX    = "latexmk"
DVI2PDF  = "dvipdfmx"
BIBTEX   = "bibtex"
BASENAME = "main"
TEX_FILE = BASENAME + ".tex"
CONVERT_COMMAND = "convert -alpha deactivate -density 150x150"

DST_FILES = {}

############################################################
## extension rules
## src_exts: array of the extentions that the destination file depends on.
## src_exts[0] is used as a 'src' of rake target.
## 'prefix' indicates head string of filenames.
def rule_src2dst(src_exts, dst_ext, prefix = nil)
  desc "convert from .#{src_exts[0]} to #{dst_ext}."
  dst_files = []
  FileList["#{prefix.to_s}*.#{src_exts[0]}"].each do |src_file|
    dst_file = src_file.ext(dst_ext)
    basename = File.basename(src_file, ".#{src_exts[0]}")
    src_files = src_exts.map {|ext| FileList["#{basename}.#{ext}"]}.flatten
    src_files.select!{|path| FileTest.exist? path }
    file dst_file => src_files do
      yield(src_files, dst_file)
    end
    dst_files << dst_file
  end
  task "#{src_exts[0]}2#{dst_ext}".to_sym => dst_files

  DST_FILES[dst_ext] ||= []
  DST_FILES[dst_ext] += dst_files
  CLEAN.include(dst_files)
end

rule_src2dst(['circo'], 'eps', 'fig') { |srcs, dst| sh "circo  -Teps #{srcs[0]} -o #{dst}"}
rule_src2dst(['circo'], 'png', 'fig') { |srcs, dst| sh "circo  -Tpng #{srcs[0]} -o #{dst}"}
rule_src2dst(['dot']  , 'eps', 'fig') { |srcs, dst| sh "dot    -Teps #{srcs[0]} -o #{dst}"}
rule_src2dst(['dot']  , 'png', 'fig') { |srcs, dst| sh "dot    -Tpng #{srcs[0]} -o #{dst}"}
rule_src2dst(['fdp']  , 'eps', 'fig') { |srcs, dst| sh "fdp    -Teps #{srcs[0]} -o #{dst}"}
rule_src2dst(['fdp']  , 'png', 'fig') { |srcs, dst| sh "fdp    -Tpng #{srcs[0]} -o #{dst}"}
rule_src2dst(['neato'], 'eps', 'fig') { |srcs, dst| sh "neato  -Teps #{srcs[0]} -o #{dst}"}
rule_src2dst(['neato'], 'png', 'fig') { |srcs, dst| sh "neato  -Tpng #{srcs[0]} -o #{dst}"}
rule_src2dst(['twopi'], 'eps', 'fig') { |srcs, dst| sh "twopi  -Teps #{srcs[0]} -o #{dst}"}
rule_src2dst(['twopi'], 'png', 'fig') { |srcs, dst| sh "twopi  -Tpng #{srcs[0]} -o #{dst}"}
rule_src2dst(['pov']  , 'png', 'fig') { |srcs, dst| sh "povray -D #{srcs[0]}"}
rule_src2dst(['pov']  , 'eps', 'fig') { |srcs, dst|
  png_file = Tempfile.new.path
  sh "povray -D #{srcs[0]} -O#{png_file}"
  sh "#{IMAGEMAGICK} #{png_file}.png #{dst}"
  FileUtils.rm png_file
}
rule_src2dst(['svg']  , 'eps', 'fig') { |srcs, dst| sh "#{INKSCAPE} -z -f #{srcs[0]} -E #{dst}" }
rule_src2dst(['svg']  , 'png', 'fig') { |srcs, dst| 
  sh "inkscape -T -z -b white #{srcs[0]} -e #{dst}"
}
rule_src2dst(['rb' , 'dat'] , 'png', 'fig') { |srcs, dst| sh "ruby #{srcs[0]}" }
rule_src2dst(['rb' , 'dat'] , 'eps', 'fig') { |srcs, dst| sh "ruby #{srcs[0]} --eps"}
rule_src2dst(['plt', 'dat'] , 'eps', 'fig') { |srcs, dst| sh "gnuplot ./#{srcs[0]}"}
##plt -> png is not prepaerd, because it requires to modify source plt file.

task :eps => [
  :dot2eps, :circo2eps, :fdp2eps, :neato2eps, #:sfdp2eps, :twopi2eps,
  :pov2eps, :svg2eps, :rb2eps, :plt2eps,
]
task :png => [
  :dot2png, :circo2png, :fdp2png, :neato2png, #:sfdp2png, :twopi2png,
  :pov2png, :svg2png, :rb2png, 
]

############################################################
## dvi
desc "Make dvi file."
DVI_FILE = "#{BASENAME}.dvi"
task :dvi => DVI_FILE
#tex_files = FileList["*.tex"]
if File.exist?(TEX_FILE)
  #file "#{DVI_FILE}" => (tex_files + DST_FILES['eps']) do
  file "#{DVI_FILE}" => (FileList["*.tex"] + FileList["list*"] + DST_FILES['eps']) do
    sh "#{LATEX} #{TEX_FILE}"
  end
else
  file "#{DVI_FILE}" => [] # Do nothing if TEX_FILE doesn't exist.
end
CLEAN.include(
  "#{BASENAME}.dvi",
  "#{BASENAME}.log",
  "#{BASENAME}.toc",
  "#{BASENAME}.fls",
  "#{BASENAME}.spl", #latexmk
  "#{BASENAME}.fdb_latexmk", #latexmk
  "#{BASENAME}.bbl", #bibtex
  "#{BASENAME}.blg", #bibtex
  "mainNotes.bib",
  "*.aux"
)

############################################################
## pdf
desc "Make pdf file."
pdfname = File.basename(Dir.pwd) + ".pdf"
task :pdf => pdfname
file pdfname => ["#{BASENAME}.dvi"] do
  sh "#{DVI2PDF} -o #{pdfname} #{BASENAME}.dvi"
end
CLEAN.include( "#{BASENAME}.pdf" )

############################################################

task :default => :dvi

