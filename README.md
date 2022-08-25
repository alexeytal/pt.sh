# pt.sh - cli periodic table

[![asciicast](https://asciinema.org/a/517219.svg)](https://asciinema.org/a/517219)

# Features
- searchable
- info cards with lots of properties for every element
- info cards are stored in csv format and can be easily extended by adding more columns

# Installation
Copy the data file to $XDG_DATA_HOME/pt.sh
```
mkdir -p $XDG_DATA_HOME/pt.sh && cp pt.csv $XDG_DATA_HOME/pt.sh
```

# Usage
```
Usage: pt.sh [OPTION]... [ELEMENT]...
Print the periodic table of element.

Positional arguments:
  element       [optional] One or multiple elements to be highlighted

Options:
 -s, -shell    highlight s,p,d elements
 -tm, -TM      highlight transiton metals
 -c, -C        print info card for the element

The file with the data for info cards is stored in `echo
$XDG_DATA_HOME/pt.sh/table.csv`.
A custom path can be set in the PT_PATH variable.
```
