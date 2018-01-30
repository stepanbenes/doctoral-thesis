pdflatex.exe main.tex --jobname thesis
bibtex.exe thesis.aux
pdflatex.exe main.tex --jobname thesis
pdflatex.exe main.tex --jobname thesis
call clean.bat