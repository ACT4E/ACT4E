
all:
	@echo do one of the following:
	@echo 	make -B ACT4E-devel-fast.pdf
	@echo 	make -B ACT4E-public-fast.pdf
	@echo 	make -B ACT4E-instructors-fast.pdf
	@echo or the "slow" variant.
	@echo Create the cached tikz using \"make tikz\".

tmpdir=tmp

ACT%.pdf: ACT%.tex .FORCE 
	max_print_line=10000 nice -n 20 latexmk -synctex=1 -pdf -shell-escape $<
	texloganalyser -r ACT$*.log > ACT$*.warnings.txt
	cp ACT$*.aux ACT$*-refs.aux

	# make copy of files - open PDF viewer on these
	cp ACT$*.log ACT$*-stable.log
	cp ACT$*.pdf ACT$*-stable.pdf
	cp ACT$*.synctex.gz ACT$*-stable.synctex.gz

%.pdf: %.tex .FORCE
	max_print_line=10000  nice -n 19 latexmk -synctex=1 -pdf -shell-escape  $<
	texloganalyser -r $*.log > $*.warnings.txt

clean:
	rm -f *.fdb_latexmk *.fls *.log  *.aux *.dvi *.out *.maf *.mtc* *.ptc* *-blx.bib *.run.xml *.idx *.toc *.bbl *.blg *.ind *.ilg  *.dep *.pyg *.ptc* *.mtc* *.gls *.tdo *.mw *warnings.txt *.synctex.gz *-tmp.* ACT4E-*.pdf

	find volumes -name 'chapter*pdf' -delete
	find volumes -name 'part*pdf' -delete
tikz:
	touch sag/*pdf
	make -C sag -j3

texs=$(wildcard volumes/vol*/*/*/*.tex)

find-missing:
	grep -r -L '% !TEX' $(texs) | grep -v snippets | grep -v standalone

chapters=$(wildcard volumes/vol*/*/*/chapter.tex)
chapters-standalones=$(subst chapter.tex,chapter-standalone.tex,$(chapters))
chapters-standalones-fast=$(subst chapter.tex,chapter-standalone-fast.tex,$(chapters))
chapters-standalones-public-fast=$(subst chapter.tex,chapter-standalone-public-fast.tex,$(chapters))
chapters-standalones-noslides-fast=$(subst chapter.tex,chapter-standalone-noslides-fast.tex,$(chapters))
chapters-pdf        =$(subst chapter.tex,chapter-standalone.pdf,$(chapters))
chapters-links      =$(subst chapter.tex,chapter-link-snippets, $(chapters))
chapters-link-minted=$(subst chapter.tex,chapter-link-minted, $(chapters))
chapters-makefiles  =$(subst chapter.tex,Makefile,              $(chapters))

parts=$(wildcard volumes/vol*/*/part.tex)
parts-standalones=$(subst part.tex,part-standalone.tex,$(parts))
parts-standalones-fast=$(subst part.tex,part-standalone-fast.tex,$(parts))
parts-standalones-noslides-fast=$(subst part.tex,part-standalone-noslides-fast.tex,$(parts))
parts-standalones-public-fast=$(subst part.tex,part-standalone-public-fast.tex,$(parts))
parts-pdf        =$(subst part.tex,part-standalone.pdf,$(parts))
parts-links      =$(subst part.tex,part-link-snippets, $(parts))
parts-link-minted=$(subst part.tex,part-link-minted,   $(parts))
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

volumes/%/Makefile: templates/template-Makefile.mk
	cp $< $@

%/chapter-standalone.tex: templates/template-chapter-standalone.tex
	cp $< $@
%/part-standalone.tex: templates/template-part-standalone.tex
	cp $< $@


%/chapter-standalone-fast.tex: templates/template-chapter-standalone-fast.tex
	cp $< $@
%/part-standalone-fast.tex: templates/template-part-standalone-fast.tex
	cp $< $@

%/chapter-standalone-public-fast.tex: templates/template-chapter-standalone-public-fast.tex
	cp $< $@
%/part-standalone-public-fast.tex: templates/template-part-standalone-public-fast.tex
	cp $< $@

%/chapter-standalone-noslides-fast.tex: templates/template-chapter-standalone-noslides-fast.tex
	cp $< $@
%/part-standalone-noslides-fast.tex: templates/template-part-standalone-noslides-fast.tex
	cp $< $@


%/chapter-standalone.pdf: %/chapter-standalone.tex %/Makefile .FORCE
	make -C $* chapter-once

%/part-standalone.pdf: %/part-standalone.tex %/Makefile .FORCE
	make -C $* part-once


standalone: \
	$(parts-standalones) \
	$(parts-standalones-fast) \
	$(parts-standalones-noslides-fast) \
	$(parts-standalones-public-fast)  \
	$(chapters-standalones) \
	$(chapters-standalones-fast) \
	$(chapters-standalones-public-fast) \
	$(chapters-standalones-noslides-fast)

links: $(chapters-links)  $(parts-links) $(chapters-link-minted) $(parts-link-minted)
makefiles: $(chapters-makefiles) $(parts-makefiles)

recursive: links standalone makefiles






generated/used.yaml: .FORCE
	@echo Generating $@...
	@lsm_collect $(shell find volumes -name '*.tex') $(shell find papers -name '*.tex')  $(shell find sag -name '*.tikz') >$@
	@echo Generating $@... done
generated/used-%.yaml: .FORCE
	@echo Generating $@
	@lsm_collect $(shell find volumes/$* -name '*.tex') $(shell find papers -name '*.tex')  $(shell find sag -name '*.tikz') >$@
	@echo Generating $@... done
nomenc-%.tex: generated/used-%.yaml utils/symbols*.tex
	lsm_nomenc  --only $< utils/symbols*.tex > $@

# lsm_nomenc  utils/symbols*.tex > $@



nomencvol1_final=volumes/vol1/80_backmatter/96_nomenclature/nomenc-vol1.texi
nomencvol1_devel=volumes/vol1/80_backmatter/96_nomenclature/nomenc-vol1-devel.texi


$(nomencvol1_final): generated/used-vol1.yaml utils/symbols*.tex
	lsm_nomenc               --style medium  --only $< utils/symbols*.tex > $@.tmp
	mv $@.tmp $@

$(nomencvol1_devel): generated/used-vol1.yaml utils/symbols*.tex
	lsm_nomenc --allow-empty --style medium  --only $< utils/symbols*.tex > $@.tmp
	mv $@.tmp $@

nomenc: $(nomencvol1_final)  $(nomencvol1_devel)

tablefile=volumes/vol1/00_front/05_developers/table.texi


table: $(tablefile)

$(tablefile): utils/symbols*.tex .FORCE
	$(MAKE) generated/used-vol1.yaml -B
	# lsm_table --verbose --only generated/used-vol1.yaml --style medium $< > $@
	lsm_table --verbose --only generated/used-vol1.yaml --style full $< > $@

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

find-equations-playground:
	lsm_equations --search volumes/vol-playground --output equations/vol-playground

find-equations-Paper_NegResults:
	lsm_equations \
		--search volumes/vol-playground/10_dp/Paper_NegResults \
		--output equations/vol-playground/10_dp/Paper_NegResults \
		--add-preamble volumes/vol-playground/10_dp/Paper_NegResults/symbols.tex

find-equations-ll:
	lsm_equations \
		--search volumes/vol1/50_opera \
		--output equations/vol1/50_opera


#find-equations-vol2:
#	lsm_equations --search volumes/vol2 --output equations/vol2

compile-equations:
	make -C equations -j -k
#	rm -rf  equations/vol1/20_orders
#	rm -rf  equations/vol1/22_operations
#	rm -rf  equations/vol1/25_translation
#	rm -rf  equations/vol1/30_design
#	rm -rf  equations/vol1/40_computation
.FORCE:
.PHONY: .FORCE


BUILD_IMAGE ?= act4e/act4e-build:alphubel

pull:
	docker pull $(BUILD_IMAGE)

as_user=-u $(shell id -u ${USER}):$(shell id -g ${USER})  -e USER=$(shell whoami) -e HOME=/tmp
# as_user=
magic:
	docker run $(as_user)  -it --rm -w $(PWD) -v $(PWD):$(PWD) \
		$(BUILD_IMAGE) \
		make nomenc table find-equations

magic-table:
	docker run $(as_user)  -it --rm -w $(PWD) -v $(PWD):$(PWD) \
		$(BUILD_IMAGE) \
		make nomenc table

magic-equations:
	docker run $(as_user) -it --rm -w $(PWD) -v $(PWD):$(PWD) \
		$(BUILD_IMAGE) \
		make find-equations

ultramagic:
	docker run $(as_user) -it --rm -w $(PWD) -v $(PWD):$(PWD) \
		$(BUILD_IMAGE) \
		sh -c 'PYTHONPATH=ACT4E-private/src:ACT4E-exercises/src: make remake'

shell:
	docker run $(as_user)  -it --rm -w $(PWD) -v $(PWD):$(PWD) \
		$(BUILD_IMAGE) \
		sh -c 'PYTHONPATH=ACT4E-private/src:ACT4E-exercises/src: bash'

docker-%:
	docker run $(as_user) -it --rm -w $(PWD) -v $(PWD):$(PWD) \
		$(BUILD_IMAGE) \
		sh -c 'PYTHONPATH=ACT4E-private/src:ACT4E-exercises/src: make $*'

pdfdir=/Users/andrea/Library/Mobile\ Documents/com~apple~CloudDocs/frazzoli-icloud/ACT4E

latexindent-version:
	latexindent -v

latexindent:
	bash -c 'for a in volumes/*/*/*/*.tex; do echo $$a; ./latexindent.sh $$a; done'
	bash -c 'for a in sag/*.tikz; do echo $$a; ./latexindent.sh $$a; done'

latexindent-quick:
	zsh latexindent-all.sh

generate-videos:
	 python3 -m act4e_videos.parsing \
	 	--config videos/videos.yaml \
		--base-url https://act4e-spring21.netlify.app/videos/ \
		--html gh-pages/videos \
		--tex  videos/generated \
		--pdfdir $(pdfdir)

generate-videos-novideo:
	 python3 -m act4e_videos.parsing \
	 	--config videos/videos.yaml \
		--base-url https://act4e-spring21.netlify.app/videos/ \
		--html gh-pages/videos \
		--tex  videos/generated \
		--pdfdir $(pdfdir) \
		--no-video

find-unused:
	python -m act4e_videos.check_used --config videos/videos.yaml --tex-src volumes > unused.txt
	cat unused.txt


check-no-tabs:
	./check_no_tabs.py .
