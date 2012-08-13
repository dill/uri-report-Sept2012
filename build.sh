#!/bin/sh

# this script builds the report

# first get R to make the Rmd -> markdown
R -e 'library(knitr);knit("report.Rmd")'

# then pandoc to make markdown to LaTeX
#pandoc -s -o report.tex report.md --template latex.template
# this is a fudge to get the captions above the figures
#  see myfilter.hs for details
pandoc -t json report.md | ./myfilter | pandoc -s -f json -t latex --template latex.template -o report.tex
#pandoc -t json report.md | pandoc -s -f json -t latex --template latex.template -o report.tex

# finally, compile the LaTeX
xelatex report.tex


#open the file up!
open report.pdf

