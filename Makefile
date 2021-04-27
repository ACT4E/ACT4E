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
	nice -n 20 latexmk -synctex=1 -pdflatex -shell-escape  -f $<
	texloganalyser -r ACT$*.log > ACT$*.warnings.txt
	cp ACT$*.aux ACT$*-refs.aux

%.pdf: %.tex .FORCE
	nice -n 20 latexmk -synctex=1 -pdflatex -shell-escape  -f $<
	texloganalyser -r $*.log > $*.warnings.txt

clean:
	rm -f *.fdb_latexmk *.fls *.log  *.aux *.dvi *.out *.maf *.mtc* *.ptc* *-blx.bib *.run.xml *.idx *.toc *.bbl *.blg *.ind *.ilg   *.ptc* *.mtc* *.gls *.tdo *.mw

# rm -f nomenc-*.tex used*yaml


tikz:
	touch sag/*pdf
	make -C sag -j

texs=$(wildcard volumes/vol*/*/*/*.tex)

find-missing:
	grep -r -L '% !TEX' $(texs) | grep -v snippets | grep -v standalone

chapters=$(wildcard volumes/vol*/*/*/chapter.tex)
chapters-standalones=$(subst chapter.tex,chapter-standalone.tex,$(chapters))
chapters-standalones-fast=$(subst chapter.tex,chapter-standalone-fast.tex,$(chapters))
chapters-pdf        =$(subst chapter.tex,chapter-standalone.pdf,$(chapters))
chapters-links      =$(subst chapter.tex,chapter-link-snippets, $(chapters))
chapters-link-minted=$(subst chapter.tex,chapter-link-minted, $(chapters))
chapters-makefiles  =$(subst chapter.tex,Makefile,              $(chapters))

parts=$(wildcard volumes/vol*/*/part.tex)
parts-standalones=$(subst part.tex,part-standalone.tex,$(parts))
parts-standalones-fast=$(subst part.tex,part-standalone-fast.tex,$(parts))
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


%/chapter-standalone-fast.tex: template-chapter-standalone-fast.tex
	cp $< $@
%/part-standalone-fast.tex: template-part-standalone-fast.tex
	cp $< $@


%/chapter-standalone.pdf: %/chapter-standalone.tex %/Makefile .FORCE
	make -C $* chapter-once

%/part-standalone.pdf: %/part-standalone.tex %/Makefile .FORCE
	make -C $* part-once


standalone: $(chapters-standalones) $(parts-standalones) $(chapters-standalones-fast) $(parts-standalones-fast)
links: $(chapters-links)  $(parts-links) $(chapters-link-minted) $(parts-link-minted)
makefiles: $(chapters-makefiles) $(parts-makefiles)

recursive: links standalone makefiles

twovolumes:
	make -B ACT4E-vol1.pdf
	make -B ACT4E-vol2.pdf
	make -B ACT4E-vol1.pdf
	make -B ACT4E-vol2.pdf

nomencvol1=volumes/vol1/50_backmatter/96_nomenclature/nomenc-vol1.tex




generated/used-%.yaml: .FORCE
	@lsm_collect $(shell find volumes/$* -name '*.tex') $(shell find papers -name '*.tex')  $(shell find sag -name '*.tikz') >$@

nomenc-%.tex: generated/used-%.yaml utils/symbols*.tex
	lsm_nomenc  --only $< utils/symbols*.tex > $@

# lsm_nomenc  utils/symbols*.tex > $@

$(nomencvol1): generated/used-vol1.yaml utils/symbols*.tex
	lsm_nomenc  --only $< utils/symbols*.tex > $@

nomenc: $(nomencvol1)  nomenc-vol2.tex

generated/used.yaml: .FORCE
	@lsm_collect $(shell find volumes -name '*.tex') $(shell find papers -name '*.tex')  $(shell find sag -name '*.tikz') >$@

tablefile=volumes/vol1/00_front/05_developers/table.tex

table: $(tablefile)

$(tablefile): utils/symbols*.tex .FORCE
	$(MAKE) generated/used.yaml -B
	lsm_table --only generated/used.yaml --style medium $< > $@
#lsm_table --only used.yaml --style full $^ > $@
#lsm_table --only used.yaml --style small $^ > $@

used-%.yaml:
	@lsm_collect $(shell find volumes/$* -name '*.tex') $(shell find papers -name '*.tex')  $(shell find sag -name '*.tikz') >$@


vol1-nomenc-update: table
	$(MAKE) table -B
	$(MAKE) nomenc -B
	pdflatex --shell-escape -synctex=1 ACT4E-vol1



pysnippets:
	pysnip-make -c make
remake:
	pysnip-make -c "clean; rmake; ls"

find-equations:
	lsm_equations --search volumes/vol1 --output equations/vol1

compile-equations:
	make -C equations -j -k
#	rm -rf  equations/vol1/20_orders
#	rm -rf  equations/vol1/22_operations
#	rm -rf  equations/vol1/25_translation
#	rm -rf  equations/vol1/30_design
#	rm -rf  equations/vol1/40_computation
.FORCE:
.PHONY: .FORCE

tag=reg-stage.zuper.ai/act4e/act4e-build:z7
pull:
	docker pull $(tag)

as_user=-u $(shell id -u ${USER}):$(shell id -g ${USER})  -e USER=$(shell whoami) -e HOME=/tmp/home
# as_user=
magic:
	docker run $(as_user)  -it --rm -w $(PWD) -v $(PWD):$(PWD) \
		$(tag) \
		make nomenc table find-equations

magic-equations:
	docker run $(as_user) -it --rm -w $(PWD) -v $(PWD):$(PWD) \
		$(tag) \
		make find-equations

ultramagic:
	docker run $(as_user) -it --rm -w $(PWD) -v $(PWD):$(PWD) \
		$(tag) \
		sh -c 'PYTHONPATH=ACT4E-private/src:ACT4E-exercises/src: make remake'

shell:
	docker run $(as_user)  -it --rm -w $(PWD) -v $(PWD):$(PWD) \
		$(tag) \
		sh -c 'PYTHONPATH=ACT4E-private/src:ACT4E-exercises/src: bash'

docker-%:
	docker run $(as_user) -it --rm -w $(PWD) -v $(PWD):$(PWD) \
		$(tag) \
		sh -c 'PYTHONPATH=ACT4E-private/src:ACT4E-exercises/src: make *'

generate-videos:
	 python3 -m act4e_videos.parsing \
	 	--config videos/videos.yaml \
		--base-url https://ACT4E.github.io/ACT4E/videos/ \
		--html gh-pages/videos \
		--tex  videos/generated
