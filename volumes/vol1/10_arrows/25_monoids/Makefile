all:

chapter-once: .FORCE
	latexmk -r ../../../../latexmkrc -C  -nobibtex chapter-standalone.tex
	latexmk -r ../../../../latexmkrc -g  -nobibtex chapter-standalone.tex

chapter-continuous: .FORCE
	latexmk -r ../../../../latexmkrc -pvc -nobibtex chapter-standalone.tex

part-once: .FORCE
	latexmk -r ../../../latexmkrc -g -nobibtex part-standalone.tex

part-continuous: .FORCE
	latexmk -r ../../../latexmkrc -pvc -nobibtex part-standalone.tex




.FORCE:
.PHONY: .FORCE
