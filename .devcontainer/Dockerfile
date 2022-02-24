FROM qmcgaw/latexdevcontainer:latest-full
RUN uname -a
RUN apt install -y make \
    python3-pip

RUN pip install -U Pygments

# RUN apt install -y \
#     software-properties-common\
# RUN add-apt-repository ppa:deadsnakes/ppa -y
# RUN apt install python3.10
# RUN python --version

RUN mkdir -p /usr/local/share/texmf/tex/latex/

RUN git clone https://github.com/ACT4E/kaobook.git tmp-kaobook
RUN cp -R tmp-kaobook   /usr/local/texlive/texmf-local/tex/latex/local

RUN mktexlsr
RUN kpsewhich kaobook.cls

