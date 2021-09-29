$pdflatex='pdflatex --shell-escape -synctex=1 -halt-on-error -file-line-error %A ';
$pdflatex .= ' && cp %A.pdf %A-tmp.pdf && cp %A.synctex.gz %A-tmp.synctex.gz  ';

$pdf_mode = 1;
$max_repeat=20;
@generated_exts = (@generated_exts, 'synctex.gz');

# add this to your ~/.latexmkrc
# $pdf_previewer = 'open -a Skim'
