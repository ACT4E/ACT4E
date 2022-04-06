
How to put the defmaps on different lines:

    \\(defmap\w+)\{([^\n]*)\}\{(.*)\}\{(.*)\}\{(.*)\}\{(.*)\}\{(.*)\}

    \\$1{\n$2\n}{\n$3\n}{\n$4\n}{\n$5\n}{\n$6\n}{\n$7\n}

Find the `\to`:

    \\to[^\w]

    (\\set\w\s*)\\to(\s*\\set\w\s*)
    $1\\sto$2
    

Don't have SY inside section:

    (\\\w*section.*)\\SY\{(.*)\}
    $1 $2

Bad substs:

    ` SY\{`
    ` \SY\{`

Too much space:

    (\\SY\{[^\}]*\}) ([,.\)\;\:\~])
    $1$2

    (\\SY\{[\w\s]*\})\s\s+
    $1 

Note SPACE and s? for plurals

    (morphisms?)([ \.\,\;\:\~])
    \\SY\{$1\}$2



Forbidden:
    "\\forslides"
    \n\n\\begin\{equation\}


SY inside SY

    \\SY\w*\{[^\}]*\\SY
