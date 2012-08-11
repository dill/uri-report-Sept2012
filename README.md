# URI report on line transect data September 2012

Here are some scripts used to generate the report.

The basic idea is that `report.Rmd` has everything that you want in it (code to generate the plots and tables). From there we run knitr to build a markdown file and run the code. Once this is done, we use pandoc to make the markdown into latex (with the additional filter to make the captions appear above the figures and a latex.template file to make things look nice). Finally, we run xelatex to build a pdf.

This is not that pretty. I am sorry.

-- David L. Miller 11 August 2012
