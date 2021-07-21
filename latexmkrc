$pdflatex='pdflatex --shell-escape -synctex=1 -halt-on-error -file-line-error ';
$pdf_mode = 1;
$max_repeat=20;
@generated_exts = (@generated_exts, 'synctex.gz', 'mw');

# add this to your ~/.latexmkrc
# $pdf_previewer = 'open -a Skim'
