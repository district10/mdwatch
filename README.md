texwatch
========

A bash script which monitors a .tex source file for modification, then compiles and previews it when it changes.

### Requirements:
- pdflatex
- evince

### Usage:
Simply call `texwatch.sh /path/to/your/document.tex`.  
The script will render the PDF and open it in evince. When you modify the tex file, the script will recompile the PDF and evince will update its preview. If the build fails, the script will print the errors.
