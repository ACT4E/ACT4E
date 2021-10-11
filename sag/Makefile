TIME     = /usr/bin/time -p
# LATEXMK  = latexmk -xelatex -silent -f -g --pdf

#PDFLATEX = xelatex -interaction=batchmode
PDFLATEX = pdflatex --shell-escape -interaction=batchmode
PDFCROP  = pdfcrop
RM       = /bin/rm

TikFiles = $(wildcard *.tikz)

%-page.tex :  head.txt %.tikz foot.txt
	cat $^ > $@

# StandAloneGraphicsTeXFiles = $(patsubst %.tikz,%.tex,$(TikFiles))

PDFGraphics = $(patsubst %.tikz,%.pdf,$(TikFiles))
Pages = $(patsubst %.tikz,%-page.tex,$(TikFiles))
PagesPDF = $(patsubst %.tikz,%-page.pdf,$(TikFiles))
# InputTeXFiles = $(wildcard *_input.tex)


all: $(PDFGraphics) $(PagesPDF) $(Pages)

pages:  $(Pages)

%.pdf : %.tex   
	$(PDFLATEX) $<
	rm -f $**.aux $**.bak $**.bbl $**.blg $**.log $**.run.xml $**blx.bib  $**.out $**.toc $**.tdo $*_region.* $*.maf $*.mtc*


%.pdf : %-page.pdf
	$(PDFCROP) $< $@


clean-aux:
	$(RM) -f -- *.aux *.bak *.bbl *.blg *.log *.run.xml *blx.bib *-page* *.out *.toc *.tdo _region.* *.auxlock  *.maf *.mtc* *.fmt


clean : .PHONY
	$(MAKE) clean-aux
	$(RM) -f -- $(PDFGraphics)
	$(RM) -f -- *-page*tex
	# $(RM) -f -- $(StandAloneGraphicsTeXFiles)




.PHONY :
