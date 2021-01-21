all:  
	@echo
	@echo Compile using \"make ready\" or \"make full\".
	@echo 
	@echo Create the chached tikz using \"make tikz\".


tmpdir=tmp

%.pdf: %.tex 
	rm -f $*.aux $(tmpdir)/$*.aux
	latexmk -xelatex -outdir=$(tmpdir) -f $<
	cp $(tmpdir)/$*.pdf $@


clean:
	rm -f *.fdb_latexmk *.fls *.log CategoricalCoDesign.pdf *.aux *.dvi *.out


ready: ACT4E-ready.pdf
full: ACT4E-full.pdf

ACT4E-ready.pdf::  chapters/*.tex utils/*.tex

ACT4E-full.pdf::  chapters/*.tex utils/*.tex


tikz:
	make -C sag -j