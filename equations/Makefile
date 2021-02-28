TIME     = /usr/bin/time -p
# LATEXMK  = latexmk -xelatex -silent -f -g --pdf

#PDFLATEX = xelatex -interaction=batchmode
PDFLATEX = pdflatex --shell-escape -halt-on-error -file-line-error #-interaction=batchmode
PDFCROP  = pdfcrop
RM       = /bin/rm

#TikFiles = $(wildcard */*.texi)
TikFiles = $(shell find . -name '*.texi')

%-page.tex :  head.txt %.texi foot.txt
	cat $^ > $@

# StandAloneGraphicsTeXFiles = $(patsubst %.tikz,%.tex,$(TikFiles))

PDFGraphics = $(patsubst %.texi,%.pdf,$(TikFiles))


# InputTeXFiles = $(wildcard *_input.tex)

all: $(PDFGraphics)

TikFiles_defs = $(shell find . -name 'def*.texi')
PDFGraphics_defs = $(patsubst %.texi,%.pdf,$(TikFiles))

defs: $(PDFGraphics_defs)

#pages: $(patsubst %.texi,%-page.tex,$(TikFiles))

%.pdf : %.tex
	#$(PDFLATEX) -output-directory $(shell dirname $@) $<
	cd $(shell dirname $@) && $(PDFLATEX) $(shell basename $*)
	rm -f $**.aux $**.bak $**.bbl $**.blg $**.log $**.run.xml $**blx.bib  $**.out $**.toc $**.tdo $*_region.* $*.maf $*.mtc* $*.mw $*.idx


%.pdf : %-page.pdf
	$(PDFCROP) --margins 10 $< $*.tmp.pdf
	cpdf $*.tmp.pdf -scale-page "3.2 3.2" -o $@
	rm -f  $*.tmp.pdf


clean-aux:
	$(RM) -f -- *.aux *.bak *.bbl *.blg *.log *.run.xml *blx.bib *-page* *.out *.toc *.tdo _region.* *.auxlock  *.maf *.mtc* *.mw *.idx


clean : .PHONY
	$(MAKE) clean-aux
	$(RM) -f -- $(PDFGraphics)
	$(RM) -f -- *-page*tex
	# $(RM) -f -- $(StandAloneGraphicsTeXFiles)




.PHONY :
