#!/bin/sh

find resources/geocoding -mindepth 1 -maxdepth 1 -type d ! -name "ru" ! -name "en" -exec rm -rf '{}' \; && \
rm -f ABC-3x.csv ABC-4x.csv ABC-8x.csv DEF-9x.csv && \
wget https://www.rossvyaz.ru/docs/articles/ABC-3x.csv && \
wget https://www.rossvyaz.ru/docs/articles/ABC-4x.csv && \
wget https://www.rossvyaz.ru/docs/articles/ABC-8x.csv && \
wget https://www.rossvyaz.ru/docs/articles/DEF-9x.csv && \
iconv -f cp1251 -t utf-8 ABC-3x.csv -o ABC-3x.csv.tmp && mv -f ABC-3x.csv.tmp ABC-3x.csv && \
iconv -f cp1251 -t utf-8 ABC-4x.csv -o ABC-4x.csv.tmp && mv -f ABC-4x.csv.tmp ABC-4x.csv && \
iconv -f cp1251 -t utf-8 ABC-8x.csv -o ABC-8x.csv.tmp && mv -f ABC-8x.csv.tmp ABC-8x.csv && \
iconv -f cp1251 -t utf-8 DEF-9x.csv -o DEF-9x.csv.tmp && mv -f DEF-9x.csv.tmp DEF-9x.csv && \
python3 my1.py && \
python3 my2.py && \
ant -f java/build.xml build-geo-data
