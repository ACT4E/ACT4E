FROM qmcgaw/latexdevcontainer:latest-full
RUN uname -a

RUN apt install make

RUN mkdir -p /usr/local/share/texmf/tex/latex/

RUN git clone https://github.com/ACT4E/kaobook.git tmp-kaobook
RUN cp -R tmp-kaobook   /usr/local/texlive/texmf-local/tex/latex/local

RUN mktexlsr
RUN kpsewhich kaobook.cls

