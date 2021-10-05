$pdflatex='pdflatex --shell-escape -synctex=1 -halt-on-error -file-line-error %A ';
$pdflatex .= ' && cp %A.pdf %A-tmp.pdf. && mv %A-tmp.pdf. %A-tmp.pdf && cp %A.synctex.gz %A-tmp.synctex.gz  ';

$pdf_mode = 1;
$max_repeat=20;
@generated_exts = (@generated_exts, 'synctex.gz');

# add this to your ~/.latexmkrc
# $pdf_previewer = 'open -a Skim'

use File::Spec;
$thisfile= File::Spec->rel2abs(__FILE__);
print("Using configuration $thisfile\n");
print("pdflatex = $pdflatex \n");
print("pdfmode = $pdf_mode \n");
print("pdf_previewer = $pdf_previewer \n");