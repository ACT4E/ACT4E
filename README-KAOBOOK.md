
Clone this repo:

    https://github.com/ACT4E/kaobook

so that it is in the directory 

    /usr/local/texlive/texmf-local/tex/latex/local/kaobook

Then do this:

    sudo mktexlsr

Now our fork of kaobook should be available for the class.


TODO/BUGS:

* There are a lot of "caption lost" errors from floatrow. Not sure why the captions are not formatted well. The hack is to remove errors from floatrow.

* The commands `providelength` and `openbox` are doubly defined (not sure by who).

* Not sure why, the itemize bullet points are too big.

So these are the hacks in `packages.tex`:

    %%% HACKS for kaobook

    \let\providelength\relax
    \let\openbox\relax

    %\newcommand*\flrow@error[1]{\PackageError\flrow@package{#1}\flrow@eh}
    \makeatletter
    \renewcommand\flrow@error[1]{}
    \makeatother
