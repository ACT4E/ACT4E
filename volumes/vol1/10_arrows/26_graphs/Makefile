all:

chapter-once: .FORCE
	latexmk -r ../../../../latexmkrc -g  -nobibtex chapter-standalone.tex

chapter-continuous: .FORCE
	latexmk -r ../../../../latexmkrc -pvc -nobibtex chapter-standalone.tex

chapter-continuous-fast: .FORCE
	latexmk -r ../../../../latexmkrc -pvc -nobibtex chapter-standalone-fast.tex

part-once: .FORCE
	latexmk -r ../../../latexmkrc -g -nobibtex part-standalone.tex

part-continuous: .FORCE
	latexmk -r ../../../latexmkrc -pvc -nobibtex part-standalone.tex

part-continuous-fast: .FORCE
	latexmk -r ../../../latexmkrc -pvc -nobibtex part-standalone-fast.tex


clean:
	rm -f *.fdb_latexmk *.fls *.log  *.aux *.dvi *.out *.maf *.mtc* *.ptc* *-blx.bib *.run.xml *.idx *.toc *.bbl *.blg *.ind *.ilg   *.ptc* *.mtc* *.gls *.tdo *.mw


.FORCE:
.PHONY: .FORCE
