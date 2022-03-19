all:

chapter-once: .FORCE
	latexmk -r ../../../../latexmkrc -g  -nobibtex -pdf chapter-standalone.tex
	cp chapter-standalone.pdf $(PWD)/chapter-standalone-stable.pdf
	cp chapter-standalone.synctex.gz  $(PWD)/chapter-standalone-stable.synctex.gz

chapter-continuous: .FORCE
	latexmk -r ../../../../latexmkrc -pvc -nobibtex -pdf chapter-standalone.tex

chapter-continuous-fast: .FORCE
	latexmk -r ../../../../latexmkrc -pvc -nobibtex -pdf  chapter-standalone-fast.tex

chapter-continuous-public-fast: .FORCE
	latexmk -r ../../../../latexmkrc -pvc -nobibtex -pdf chapter-standalone-public-fast.tex

chapter-continuous-noslides-fast: .FORCE
	latexmk -r ../../../../latexmkrc -pvc -nobibtex -pdf chapter-standalone-noslides-fast.tex

part-once: .FORCE
	latexmk -r ../../../latexmkrc -g  -pdf part-standalone.tex
	cp part-standalone.pdf $(PWD)/part-standalone-stable.pdf
	cp part-standalone.synctex.gz  $(PWD)/part-standalone-stable.synctex.gz

part-once-fast: .FORCE
	latexmk -r ../../../latexmkrc -g -pdf part-standalone-fast.tex
	cp part-standalone-fast.pdf $(PWD)/part-standalone-fast-stable.pdf
	cp part-standalone-fast.synctex.gz $(PWD)/part-standalone-fast-stable.synctex.gz

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
