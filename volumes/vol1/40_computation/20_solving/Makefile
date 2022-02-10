all:

chapter-once: .FORCE
	latexmk -r ../../../../latexmkrc -g  -nobibtex -pdf chapter-standalone.tex
	cp chapter-standalone.pdf chapter-standalone-fast-stable.pdf
	cp chapter-standalone.synctex.gz  chapter-standalone-fast-stable.synctex.gz

chapter-continuous: .FORCE
	latexmk -r ../../../../latexmkrc -pvc -nobibtex -pdf chapter-standalone.tex

chapter-continuous-fast: .FORCE
	latexmk -r ../../../../latexmkrc -pvc -nobibtex -pdf chapter-standalone-fast.tex

chapter-continuous-public-fast: .FORCE
	latexmk -r ../../../../latexmkrc -pvc -nobibtex -pdf chapter-standalone-public-fast.tex

chapter-continuous-noslides-fast: .FORCE
	latexmk -r ../../../../latexmkrc -pvc -nobibtex -pdf chapter-standalone-noslides-fast.tex

part-once: .FORCE
	latexmk -r ../../../latexmkrc -g  -pdf part-standalone.tex

part-continuous: .FORCE
	latexmk -r ../../../latexmkrc -pvc   -pdf part-standalone.tex

part-continuous-fast: .FORCE
	latexmk -r ../../../latexmkrc -pvc  -pdf part-standalone-fast.tex

part-continuous-public-fast: .FORCE
	latexmk -r ../../../latexmkrc -pvc  -pdf part-standalone-public-fast.tex

clean:
	rm -f *.fdb_latexmk *.fls *.log  *.aux *.dvi *.out *.maf *.mtc* *.ptc* *-blx.bib *.run.xml *.idx *.toc *.bbl *.blg *.ind *.ilg   *.ptc* *.mtc* *.gls *.tdo *.mw


.FORCE:
.PHONY: .FORCE
