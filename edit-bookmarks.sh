#!/bin/sh

# takes bookmark file and pdf

bookmarks=$(basename "$1")
pdf=$(basename "$2")
cp "$pdf" "${pdf%.*}.bak.pdf"
pdf_data="${pdf%.*}.data"
pdf_bookmarks="${pdf%.*}.bkmrks"

echo "Converting bookmarks to pdftk format..."
awk -F "@" -f translate.awk "$bookmarks" > "$pdf_bookmarks"

echo "Dumping pdf metadata..."
pdftk "$pdf" dump_data_utf8 output "$pdf_data"

echo "Inserting bookmarks..."
sed -i "/^NumberOfPages/ r $pdf_bookmarks" "$pdf_data"

echo "Creating new pdf..."
pdftk "$pdf" update_info_utf8 "$pdf_data" output "${pdf%.*}_new.pdf"

echo "Cleaning up files..."
rm "$pdf"
mv "${pdf%.*}_new.pdf" "$pdf"
rm "$pdf_data" "$pdf_bookmarks"
