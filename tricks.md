
How to put the defmaps on different lines:

    \\(defmap\w+)\{([^\n]*)\}\{(.*)\}\{(.*)\}\{(.*)\}\{(.*)\}\{(.*)\}

    \\$1{\n$2\n}{\n$3\n}{\n$4\n}{\n$5\n}{\n$6\n}{\n$7\n}

Find the `\to`:

    \\to[^\w]

    (\\set\w\s*)\\to(\s*\\set\w\s*)
    $1\\sto$2
    