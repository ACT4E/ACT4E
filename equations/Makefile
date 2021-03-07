TIME     = /usr/bin/time -p
PDFLATEX = nice -n 20 pdflatex --shell-escape -halt-on-error -file-line-error
#-interaction=batchmode
PDFCROP  = pdfcrop
RM       = /bin/rm

Sources = $(shell find . -name '*.texi')

%-page.tex :  head.txt %.texi foot.txt
	cat $^ > $@


PDFGraphics = $(patsubst %.texi,%.pdf,$(Sources))
Pages = $(patsubst %.texi,%-page.tex,$(Sources))



all: $(PDFGraphics)  $(Pages)

pages: $(Pages)

Sources_defs = $(shell find . -name 'def*.texi')
PDFGraphics_defs = $(patsubst %.texi,%.pdf,$(Sources))

defs: $(PDFGraphics_defs)

#pages: $(patsubst %.texi,%-page.tex,$(Sources))
%.pdf : %.tex
	cd $(shell dirname $@) && $(PDFLATEX) $(shell basename $*)
	rm -f $**.aux $**.bak $**.bbl $**.blg $**.log $**.run.xml $**blx.bib  $**.out $**.toc $**.tdo $*_region.* $*.maf $*.mtc* $*.mw $*.idx


%.pdf : %-page.pdf
	$(PDFCROP) --margins 2 $< $*.tmp.pdf

	cpdf $*.tmp.pdf -scale-page "3.2 3.2" -o  $*.tmp2.pdf
	cpdf -set-metadata-date 2010-01-01 $*.tmp2.pdf -o $*.tmp3.pdf
	mv  $*.tmp3.pdf $@
	rm -f  $*.tmp*.pdf
#$(PDFCROP) --margins 10 $< $*.tmp.pdf
#cpdf $*.tmp.pdf -scale-page "2.0 2.0" -o $@

clean-aux:
	$(RM) -f -- *.aux *.bak *.bbl *.blg *.log *.run.xml *blx.bib *-page* *.out *.toc *.tdo _region.* *.auxlock  *.maf *.mtc* *.mw *.idx


clean : .PHONY
	$(MAKE) clean-aux
	$(RM) -f -- $(PDFGraphics)  $(Pages)



.PHONY :
