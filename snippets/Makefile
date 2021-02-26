TIME     = /usr/bin/time -p
# LATEXMK  = latexmk -xelatex -silent -f -g --pdf

#PDFLATEX = xelatex -interaction=batchmode
PDFLATEX = pdflatex --shell-escape -interaction=batchmode
PDFCROP  = pdfcrop
RM       = /bin/rm

TikFiles = $(wildcard *.tex)

out/%-page.tex :  head.txt %.tex foot.txt
	cat $^ > $@

# StandAloneGraphicsTeXFiles = $(patsubst %.tikz,%.tex,$(TikFiles))

PDFGraphics = $(patsubst %.tex,out/%.pdf,$(TikFiles))

# InputTeXFiles = $(wildcard *_input.tex)

all: $(PDFGraphics)


out/%.pdf : out/%.tex  ../utils/*.tex
	$(PDFLATEX) $<
	rm -f $**.aux $**.bak $**.bbl $**.blg $**.log $**.run.xml $**blx.bib  $**.out $**.toc $**.tdo $*_region.* $*.maf $*.mtc*


%.pdf : %-page.pdf
	$(PDFCROP) $< $@


clean-aux:
	$(RM) -f -- *.aux *.bak *.bbl *.blg *.log *.run.xml *blx.bib *-page* *.out *.toc *.tdo _region.* *.auxlock  *.maf *.mtc*


clean : .PHONY
	$(MAKE) clean-aux
	$(RM) -f -- $(PDFGraphics)
	$(RM) -f -- *-page*tex
	# $(RM) -f -- $(StandAloneGraphicsTeXFiles)




.PHONY :
