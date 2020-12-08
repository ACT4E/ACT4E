all: CategoricalCoDesign.pdf

# all:  CategoricalCoDesign_ch2_basic.pdf

# all: dp_category.pdf

# all:  CategoricalCoDesign_ch3_quantitative.pdf
CategoricalCoDesign.pdf:: chapters/*.tex

tmpdir=tmp

%.pdf: %.tex 
	rm -f $*.aux $(tmpdir)/$*.aux
	latexmk -pdf -outdir=$(tmpdir)  $<
	cp $(tmpdir)/$*.pdf $@


clean:
	rm -f *.fdb_latexmk *.fls *.log CategoricalCoDesign.pdf *.aux *.dvi *.out
