TIME     = /usr/bin/time -p
LATEXMK  = latexmk -silent -f -g --pdf
PDFLATEX = pdflatex -interaction=batchmode
PDFCROP  = pdfcrop
RM       = /bin/rm

TikFiles = $(wildcard *.tikz)


%.tex :  head.txt %.tikz foot.txt
	cat $^ > $@

StandAloneGraphicsTeXFiles = $(patsubst %.tikz,%.tex,$(TikFiles))

PDFGraphics = $(patsubst %.tex,%.pdf,$(StandAloneGraphicsTeXFiles))

InputTeXFiles = $(wildcard *_input.tex)

all: $(PDFGraphics)


%.pdf : %.tex ../preamble*tex
	$(PDFLATEX) $< 
	$(PDFCROP) $@ $@
	rm -f $%*.aux $%*.bak $%*.bbl $%*.blg $%*.log $%*.out $%*.toc $%*.tdo _region.*

clean : .PHONY
	$(RM) -f -- *.aux *.bak *.bbl *.blg *.log *.out *.toc *.tdo _region.* *.auxlock
	$(RM) -f -- $(PDFGraphics)




.PHONY :