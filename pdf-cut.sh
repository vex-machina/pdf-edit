#!/bin/sh

# pdf-cut <pages> <pdf>

pagelist=$(basename "$1")
pdf=$(basename "$2")
cp "$pdf" "${pdf%.*}.bak.pdf"
pages=`cat "$pagelist" | tr "\n" " "`

echo "Creating new  pdf..."
# shell doesn't like strings with spaces so we use eval
eval "pdftk $pdf cat $pages output ${pdf%.*}_new.pdf"

rm "$pdf"
mv "${pdf%.*}_new.pdf" "$pdf"
