all:
	@echo
	@echo Compile using \"make ready\" or \"make full\".
	@echo
	@echo Create the chached tikz using \"make tikz\".


tmpdir=tmp

%.pdf: %.tex
	rm -f $*.aux $(tmpdir)/$*.aux
	latexmk -pdflatex -outdir=$(tmpdir) -f $<
	cp $(tmpdir)/$*.pdf $@


clean:
	rm -f *.fdb_latexmk *.fls *.log CategoricalCoDesign.pdf *.aux *.dvi *.out


ready: ACT4E-ready.pdf
full: ACT4E-full.pdf
full-fast: ACT4E-full-fast.pdf

ACT4E-ready.pdf::  chapters/*.tex utils/*.tex common.tex

ACT4E-full.pdf::  chapters/*.tex utils/*.tex  common.tex

ACT4E-full-fast.pdf::  chapters/*.tex utils/*.tex  common.tex


tikz:
	touch sag/*pdf
	make -C sag -j
