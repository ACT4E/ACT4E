TIME     = /usr/bin/time -p
LATEXMK  = latexmk -xelatex -silent -f -g --pdf
PDFLATEX = xelatex -interaction=batchmode
PDFCROP  = pdfcrop
RM       = /bin/rm

TikFiles = $(wildcard *.tikz)


%-page.tex :  head.txt %.tikz foot.txt
	cat $^ > $@

# StandAloneGraphicsTeXFiles = $(patsubst %.tikz,%.tex,$(TikFiles))

PDFGraphics = $(patsubst %.tikz,%.pdf,$(TikFiles))

# InputTeXFiles = $(wildcard *_input.tex)

all: $(PDFGraphics)


%.pdf : %.tex  
	$(PDFLATEX) $< 
	rm -f $**.aux $**.bak $**.bbl $**.blg $**.log $**.out $**.toc $**.tdo $*_region.*


%.pdf : %-page.pdf
	$(PDFCROP) $< $@

clean : .PHONY
	$(RM) -f -- *.aux *.bak *.bbl *.blg *.log *.out *.toc *.tdo _region.* *.auxlock
	$(RM) -f -- $(PDFGraphics)
	$(RM) -f -- *-page*tex
	# $(RM) -f -- $(StandAloneGraphicsTeXFiles)




.PHONY :