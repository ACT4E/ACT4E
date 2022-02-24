FROM qmcgaw/latexdevcontainer:latest-full
ARG USERNAME=vscode
USER root
RUN tlmgr update --self && \
    tlmgr install latexindent latexmk && \
    tlmgr install mathexam setspace adjustbox xkeyval collectbox enumitem lastpage && \
    texhash
USER ${USERNAME}
