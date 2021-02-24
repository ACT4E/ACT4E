all:
	@echo do
	@echo 	make -B ACT4E-vol1.pdf
	@echo 	make -B ACT4E-vol1-final.pdf
	@echo 	make -B ACT4E-vol2.pdf
	@echo Create the chached tikz using \"make tikz\".


tmpdir=tmp

#%.pdf: %.tex
#	rm -f $*.aux $(tmpdir)/$*.aux
#	latexmk -pdflatex -outdir=$(tmpdir) -f $<
#	cp $(tmpdir)/$*.pdf $@


ACTE-vol%.pdf:: nomenc-vol%.tex redo-nomenc

ACT%.pdf: ACT%.tex .FORCE
	#rm -f $*.aux
	latexmk -synctex=1 -pdflatex -shell-escape  -f $<
	# latexmk does not seem to do this, even though we put in latexmkrc
	# makeindex $*.nlo -s nomencl.ist -o $*.nls
	#pdflatex --shell-escape -synctex=1 -shell-escape $*
	cp ACT$*.aux ACT$*-refs.aux

clean:
	rm -f *.fdb_latexmk *.fls *.log  *.aux *.dvi *.out *.maf *.mtc* *.ptc* *-blx.bib *.run.xml *.idx *.toc *.bbl *.blg *.ind *.ilg   *.ptc* *.mtc* *.gls

# rm -f nomenc-*.tex used*yaml


tikz:
	touch sag/*pdf
	make -C sag -j



chapters=$(wildcard volumes/vol*/*/*/main.tex)
chapters-standalones=$(subst main.tex,chapter-standalone.tex,$(chapters))
chapters-pdf        =$(subst main.tex,chapter-standalone.pdf,$(chapters))
chapters-links      =$(subst main.tex,chapter-link-snippets, $(chapters))
chapters-link-minted=$(subst main.tex,chapter-link-minted, $(chapters))
chapters-makefiles  =$(subst main.tex,Makefile,              $(chapters))

parts=$(wildcard volumes/vol*/*/part.tex)
parts-standalones=$(subst part.tex,part-standalone.tex,$(parts))
parts-pdf        =$(subst part.tex,part-standalone.pdf,$(parts))
parts-links      =$(subst part.tex,part-link-snippets, $(parts))
parts-link-minted =$(subst part.tex,part-link-minted, $(parts))
parts-makefiles  =$(subst part.tex,Makefile,           $(parts))

parts-pdf: $(parts-pdf)
chapters-pdf: $(chapters-pdf)

clean-links:
	find volumes -type l -name '*link*'  -delete

%/chapter-link-snippets:
	cd $*  && ln -f -F -s ../../../../snippets  chapter-link-snippets
%/part-link-snippets:
	cd $*  && ln -f -F -s ../../../snippets  part-link-snippets

%/chapter-link-minted:
	cd $*  && ln -f -F -s ../../../../cache-minted  chapter-link-minted
%/part-link-minted:
	cd $*  && ln -f -F -s ../../../cache-minted  part-link-minted

volumes/%/Makefile: template-Makefile.mk
	cp $< $@

%/chapter-standalone.tex: template-chapter-standalone.tex
	cp $< $@
%/part-standalone.tex: template-part-standalone.tex
	cp $< $@


%/chapter-standalone.pdf: %/chapter-standalone.tex %/Makefile .FORCE
	make -C $* chapter-once

%/part-standalone.pdf: %/part-standalone.tex %/Makefile .FORCE
	make -C $* part-once


standalone: $(chapters-standalones) $(parts-standalones)
links: $(chapters-links)  $(parts-links) $(chapters-link-minted) $(parts-link-minted)
makefiles: $(chapters-makefiles) $(parts-makefiles)

recursive: links standalone makefiles

twovolumes:
	make -B ACT4E-vol1.pdf
	make -B ACT4E-vol2.pdf
	make -B ACT4E-vol1.pdf
	make -B ACT4E-vol2.pdf



used-%.yaml:
	@lsm_collect $(shell find volumes/$* -name '*.tex') $(shell find papers -name '*.tex')  $(shell find sag -name '*.tikz') >$@

nomenc-%.tex: used-%.yaml
	lsm_nomenc  --only $< utils/symbols*.tex > $@
	# lsm_nomenc  utils/symbols*.tex > $@

nomenc: nomenc-vol1.tex  nomenc-vol2.tex

#
#redo-nomenc: nomenc
#	makeindex ACT4E-vol1.nlo -s nomencl.ist -o ACT4E-vol1.nls
#	makeindex ACT4E-vol2.nlo -s nomencl.ist -o ACT4E-vol2.nls


used.yaml:
	@lsm_collect $(shell find volumes -name '*.tex') $(shell find papers -name '*.tex')  $(shell find sag -name '*.tikz') >$@

tablefile=volumes/vol1/00_front/05_developers/table.tex
table: $(tablefile)

$(tablefile): utils/symbols*.tex
	$(MAKE) used.yaml -B
	#lsm_table --only used.yaml --style full $^ > $@
	lsm_table --only used.yaml --style small $^ > $@


used-%.yaml:
	@lsm_collect $(shell find volumes/$* -name '*.tex') $(shell find papers -name '*.tex')  $(shell find sag -name '*.tikz') >$@


vol1-nomenc-update: table
	$(MAKE) used.yaml -B
	$(MAKE) table -B
	$(MAKE) nomenc -B
	pdflatex --shell-escape -synctex=1 ACT4E-vol1



pysnippets:
	pysnip-make -c make
remake:
	pysnip-make -c "clean; rmake; ls"



.FORCE:
.PHONY: .FORCE
