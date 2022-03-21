TIME     = /usr/bin/time -p
# LATEXMK  = latexmk -xelatex -silent -f -g --pdf

#PDFLATEX = xelatex -interaction=batchmode
PDFLATEX = pdflatex --shell-escape -interaction=batchmode
PDFCROP  = pdfcrop
RM       = /bin/rm

TikFiles = $(wildcard *.tikz)

#%-page.tex :  head.txt %.tikz foot.txt
#	cat $^ > $@

# StandAloneGraphicsTeXFiles = $(patsubst %.tikz,%.tex,$(TikFiles))

PDFGraphics = $(patsubst %.tikz,%.pdf,$(TikFiles))
#Pages = $(patsubst %.tikz,%-page.tex,$(TikFiles))
#PagesPDF = $(patsubst %.tikz,%-page.pdf,$(TikFiles))

Displays = $(patsubst %.tikz,display/%.pdf,$(TikFiles))
# InputTeXFiles = $(wildcard *_input.tex)

display/%.pdf: %.pdf
	cpdf $< -scale-page "3.2 3.2" -o  $*.tmp2.pdf
	cpdf -set-metadata-date 2010-01-01 $*.tmp2.pdf -o $*.tmp3.pdf
	rm $*.tmp2.pdf
	mv $*.tmp3.pdf $@

all: $(PDFGraphics) $(Displays)

displays: $(Displays)
#pages:  $(Pages)

%.pdf : %.tikz
	cat head.txt $*.tikz foot.txt > $*-page.tex
	$(PDFLATEX) $*-page
	$(PDFCROP) $*-page.pdf $@
	rm $*-page*
	rm -f $**.aux $**.bak $**.bbl $**.blg $**.log $**.run.xml $**blx.bib  $**.out $**.toc $**.tdo $*_region.* $*.maf $*.mtc* $**.mw

#
#%.pdf : %-page.pdf
	#$(PDFCROP) $< $@


clean-aux:
	$(RM) -f -- *.aux *.bak *.bbl *.blg *.log *.run.xml *blx.bib *-page* *.out *.toc *.tdo _region.* *.auxlock  *.maf *.mtc* *.fmt


clean : .PHONY
	$(MAKE) clean-aux
	$(RM) -f -- $(PDFGraphics)
	$(RM) -f -- *-page*tex
	# $(RM) -f -- $(StandAloneGraphicsTeXFiles)




.PHONY :
