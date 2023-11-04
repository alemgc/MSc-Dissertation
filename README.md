# Dissertation

Here are the scripts for scraping data from SIAF Peru for my master's thesis.
The downloaded data is in '.xls' format.
To convert it to '.xlsx', one can use LibreOffice, as follows.
It is best to put all the .xls in a single folder, say 'data', and then, in a terminal:

```bash
# MacOS
cd data
soffice --headless --convert-to xlsx *.xls

# Linux
cd data
libreoffice --headless --convert-to xlsx *.xls
```
