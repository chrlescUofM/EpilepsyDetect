#!/bin/bash
latexmk -bibtex *.tex -pdf
rm *.aux *.dvi *.fdb_latexmk *.fls *.log
evince *.pdf &
