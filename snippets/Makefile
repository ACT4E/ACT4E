TIME     = /usr/bin/time -p

PDFLATEX = nice -n 20 pdflatex --shell-escape -halt-on-error -file-line-error 
#-interaction=batchmode
PDFCROP  = pdfcrop
RM       = /bin/rm

TikFiles = $(wildcard */*.texi)

%-page.tex :  head.txt %.texi foot.txt
	cat $^ > $@

# StandAloneGraphicsTeXFiles = $(patsubst %.tikz,%.tex,$(TikFiles))

PDFGraphics = $(patsubst %.texi,%.pdf,$(TikFiles))


# InputTeXFiles = $(wildcard *_input.tex)

all: $(PDFGraphics)

#pages: $(patsubst %.texi,%-page.tex,$(TikFiles))

%.pdf : %.tex
	#$(PDFLATEX) -output-directory $(shell dirname $@) $<
	cd $(shell dirname $@) && $(PDFLATEX) $(shell basename $*)
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
