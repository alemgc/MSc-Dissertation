# Dissertation

Aquí se encuentran los scripts para el scraping de data del SIAF Perú para mi tesis de maestría.
La data descargada se encuentra en formato '.xls'.
Para convertirla en '.xlsx' y procesarla en STATA, se puede usar LibreOffice, de la siguiente manera.
Lo mejor es poner todos los .xls en una sola carpeta, digamos 'data', y luego, en un terminal:

```bash
# En MacOS
cd data
soffice --headless --convert-to xlsx *.xls

# En Linux
cd data
libreoffice --headless --convert-to xlsx *.xls
```
