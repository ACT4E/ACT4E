all:

chapter-once: .FORCE
	latexmk -r ../../../../latexmkrc -g  -nobibtex -pdf chapter-standalone.tex
	cp chapter-standalone.pdf $(CURDIR)/chapter-standalone-stable.pdf
	cp chapter-standalone.synctex.gz  $(CURDIR)/chapter-standalone-stable.synctex.gz

chapter-continuous: .FORCE
	latexmk -r ../../../../latexmkrc -pvc -nobibtex -pdf chapter-standalone.tex

chapter-continuous-fast: .FORCE
	latexmk -r ../../../../latexmkrc -pvc -nobibtex -pdf chapter-standalone-fast.tex

chapter-continuous-public-fast: .FORCE
	latexmk -r ../../../../latexmkrc -pvc -nobibtex -pdf chapter-standalone-public-fast.tex

chapter-continuous-noslides-fast: .FORCE
	latexmk -r ../../../../latexmkrc -pvc -nobibtex -pdf chapter-standalone-noslides-fast.tex

base=$(shell basename $(CURDIR))

part-once: .FORCE
	echo $(base)
	latexmk -r ../../../latexmkrc -pdf part-standalone.tex
	cp part-standalone.pdf $(CURDIR)/$(base)-stable.pdf.tmp
	cp part-standalone.synctex.gz  $(CURDIR)/$(base)-stable.synctex.gz.tmp
	mv $(CURDIR)/$(base)-stable.synctex.gz.tmp $(CURDIR)/$(base)-stable.synctex.gz
	mv $(CURDIR)/$(base)-stable.pdf.tmp $(CURDIR)/$(base)-stable.pdf

part-once-fast: .FORCE
	latexmk -r ../../../latexmkrc -pdf part-standalone-fast.tex
	cp part-standalone-fast.pdf $(CURDIR)/$(base)-fast-stable.pdf.tmp
	cp part-standalone-fast.synctex.gz  $(CURDIR)/$(base)-fast-stable.synctex.gz.tmp
	mv $(CURDIR)/$(base)-fast-stable.synctex.gz.tmp $(CURDIR)/$(base)-fast-stable.synctex.gz
	mv $(CURDIR)/$(base)-fast-stable.pdf.tmp $(CURDIR)/$(base)-fast-stable.pdf

part-once-force: .FORCE
	echo $(base)
	latexmk -r ../../../latexmkrc -g -pdf part-standalone.tex
	cp part-standalone.pdf $(CURDIR)/$(base)-stable.pdf.tmp
	cp part-standalone.synctex.gz  $(CURDIR)/$(base)-stable.synctex.gz.tmp
	mv $(CURDIR)/$(base)-stable.synctex.gz.tmp $(CURDIR)/$(base)-stable.synctex.gz
	mv $(CURDIR)/$(base)-stable.pdf.tmp $(CURDIR)/$(base)-stable.pdf

part-once-fast-force: .FORCE
	latexmk -r ../../../latexmkrc -g -pdf part-standalone-fast.tex
	cp part-standalone-fast.pdf $(CURDIR)/$(base)-fast-stable.pdf.tmp
	cp part-standalone-fast.synctex.gz  $(CURDIR)/$(base)-fast-stable.synctex.gz.tmp
	mv $(CURDIR)/$(base)-fast-stable.synctex.gz.tmp $(CURDIR)/$(base)-fast-stable.synctex.gz
	mv $(CURDIR)/$(base)-fast-stable.pdf.tmp $(CURDIR)/$(base)-fast-stable.pdf

part-continuous: .FORCE
	latexmk -r ../../../latexmkrc -pvc -pdf part-standalone.tex

part-continuous-fast: .FORCE
	latexmk -r ../../../latexmkrc -pvc -pdf part-standalone-fast.tex

part-continuous-public-fast: .FORCE
	latexmk -r ../../../latexmkrc -pvc -pdf part-standalone-public-fast.tex

clean:
	rm -f *.fdb_latexmk *.fls *.log  *.aux *.dvi *.out *.maf *.mtc* *.ptc* *-blx.bib *.run.xml *.idx *.toc *.bbl *.blg *.ind *.ilg   *.ptc* *.mtc* *.gls *.tdo *.mw *synctex.gz  part-*pdf chapter-*pdf *.pyg


.FORCE:
.PHONY: .FORCE
