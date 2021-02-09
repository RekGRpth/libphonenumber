#!/bin/sh

find resources/geocoding -mindepth 1 -maxdepth 1 -type d ! -name "ru" ! -name "en" -exec rm -rf '{}' \; && \
rm -f ABC-3xx.csv ABC-4xx.csv ABC-8xx.csv DEF-9xx.csv && \
#https://rossvyaz.gov.ru/deyatelnost/resurs-numeracii/vypiska-iz-reestra-sistemy-i-plana-numeracii \
wget -c https://rossvyaz.gov.ru/data/ABC-3xx.csv --no-check-certificate --output-document=ABC-3xx.csv && \
wget -c https://rossvyaz.gov.ru/data/ABC-4xx.csv --no-check-certificate --output-document=ABC-4xx.csv && \
wget -c https://rossvyaz.gov.ru/data/ABC-8xx.csv --no-check-certificate --output-document=ABC-8xx.csv && \
wget -c https://rossvyaz.gov.ru/data/DEF-9xx.csv --no-check-certificate --output-document=DEF-9xx.csv && \
#iconv -f cp1251 -t utf-8 ABC-3xx.csv -o ABC-3xx.csv.tmp && mv -f ABC-3xx.csv.tmp ABC-3xx.csv && \
#iconv -f cp1251 -t utf-8 ABC-4xx.csv -o ABC-4xx.csv.tmp && mv -f ABC-4xx.csv.tmp ABC-4xx.csv && \
#iconv -f cp1251 -t utf-8 ABC-8xx.csv -o ABC-8xx.csv.tmp && mv -f ABC-8xx.csv.tmp ABC-8xx.csv && \
#iconv -f cp1251 -t utf-8 DEF-9xx.csv -o DEF-9xx.csv.tmp && mv -f DEF-9xx.csv.tmp DEF-9xx.csv && \
python3 my1.py && \
python3 my2.py && \
cat resources/geocoding/ru/7.txt | sort -u > resources/geocoding/ru/7.txt.s && \
mv -f resources/geocoding/ru/7.txt.s resources/geocoding/ru/7.txt && \
ant -f java/build.xml build-geo-data
