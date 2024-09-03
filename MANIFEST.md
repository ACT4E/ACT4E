---

# First Work: The kaobook Class

MANIFEST.md
Copyright 2020-2021 Federico Marotta

This work may be distributed and/or modified under the
conditions of the LaTeX Project Public License, either version 1.3
of this license or (at your option) any later version.
The latest version of this license is in

  http://www.latex-project.org/lppl.txt

and version 1.3 or later is part of all distributions of LaTeX
version 2005/12/01 or later.

This work has the LPPL maintenance status `maintained'.

The Current Maintainer of this work is Federico Marotta.

This work consists of all files listed below.

---

```
kaobook/
|-- kaobook.cls                 - book-specific definitions
|-- kaohandt.cls                - handout-specific definitions
`-- styles/
	|-- kao.sty					- main definitions
    |-- environments.sty        - definitions for environments
	|-- kaobiblio.sty			- style of the bibliography
    |-- mdftheorems.sty         - colorful styling of theorems
    |-- packages.sty            - useful packages
    |-- plaintheorems.sty       - minimalistic styling of theorems
	`-- kaorefs.sty             - commands for referencing
```

---

# Second Work: Templates and Examples

This work is released into the public domain using the CC0 code. To the 
extent possible under law, I waive all copyright and related or 
neighbouring rights to this work. To view a copy of the CC0 code, visit:

  http://creativecommons.org/publicdomain/zero/1.0

This work consists of all files listed below as well as the products of 
their compilation.

---

```
kaobook/
`-- examples/
	|-- books/
	|	`-- minimal.tex
	|-- documentation/
	|	|-- main.bib
	|	|-- main.tex
	|	`-- chapters/
	|		|-- appendix.tex
	|		|-- figsntabs.tex
	|		|-- introduction.tex
	|		|-- layout.tex
	|		|-- mathematics.tex
	|		|-- options.tex
	|		|-- preface.tex
	|		|-- references.tex
	|		`-- textnotes.tex
	`-- reports/
		|-- minimal/
		|	`-- minimal.tex
		`-- machine_learnin_project/
			`-- main.tex
```

As regards the files in the `kaobook/examples/documentation/images` 
directory, they were downloaded from [Wikimedia 
Commons](https://commons.wikimedia.org/wiki/Main_Page) and are 
attributed inside the example book where they are used.
