# pt.sh - cli periodic table

[![asciicast](https://asciinema.org/a/517531.svg)](https://asciinema.org/a/517531)

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
Usage: pt.sh [option] [element]
Print the periodic table of element.

Positional arguments:
  element       [optional] One or multiple elements to be highlighted

Options:
 -h, --help     print help
 -s, --shell    highlight s,p,d, and f elements
 -g, --group    group elements of the periodic table
 -c, --card     print detailed info for an element

The file with the data for the info cards is stored in `echo $XDG_DATA_HOME/pt/table.csv`.
A custom path can be set in the PT_PATH variable.
```
