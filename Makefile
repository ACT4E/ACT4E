all:
	@echo
	@echo Compile using \"make ready\" or \"make full\".
	@echo
	@echo Create the chached tikz using \"make tikz\".


tmpdir=tmp

#%.pdf: %.tex
#	rm -f $*.aux $(tmpdir)/$*.aux
#	latexmk -pdflatex -outdir=$(tmpdir) -f $<
#	cp $(tmpdir)/$*.pdf $@

%.pdf: %.tex
	#rm -f $*.aux
	latexmk -pdflatex   -f $<

clean:
	rm -f *.fdb_latexmk *.fls *.log  *.aux *.dvi *.out *.maf *.mtc* *.ptc* *-blx.bib *.run.xml *.idx *.toc *.bbl *.blg *.ind *.ilg   *.ptc* *.mtc*


ready: ACT4E-ready.pdf
full: ACT4E-full.pdf
full-fast: ACT4E-full-fast.pdf

ACT4E-ready.pdf::  chapters/*.tex utils/*.tex common.tex

ACT4E-full.pdf::  chapters/*.tex utils/*.tex  common.tex

ACT4E-full-fast.pdf::  chapters/*.tex utils/*.tex  common.tex


tikz:
	touch sag/*pdf
	make -C sag -j 
	
%/standalone.tex:
	cp template-standalone.tex $@


mains=$(wildcard volumes/vol*/part*/*/main.tex)
standalones=$(subst main.tex,standalone.tex,$(mains))

standalone: $(standalones)


twovolumes:
	make -B ACT4E-vol1.pdf
	make -B ACT4E-vol2.pdf
	make -B ACT4E-vol1.pdf
	make -B ACT4E-vol2.pdf

