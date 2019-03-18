#!/bin/sh

find resources/geocoding -mindepth 1 -maxdepth 1 -type d ! -name "ru" ! -name "en" -exec rm -rf '{}' \; && \
rm -f reestr-otkrytykh-dannykh ABC-3x.csv ABC-4x.csv ABC-8x.csv DEF-9x.csv && \
wget -c "https://rossvyaz.ru/about/otkrytoe-pravitelstvo/otkrytye-dannee/reestr-otkrytykh-dannykh" && \
wget -c "https://rossvyaz.ru$(cat reestr-otkrytykh-dannykh | grep -P "CSV-" | sed 's|<br />|\n|gi' | grep "CSV-ABC-3" | grep -oP "/upload.*csv")" -O ABC-3x.csv && \
wget -c "https://rossvyaz.ru$(cat reestr-otkrytykh-dannykh | grep -P "CSV-" | sed 's|<br />|\n|gi' | grep "CSV-ABC-4" | grep -oP "/upload.*csv")" -O ABC-4x.csv && \
wget -c "https://rossvyaz.ru$(cat reestr-otkrytykh-dannykh | grep -P "CSV-" | sed 's|<br />|\n|gi' | grep "CSV-ABC-8" | grep -oP "/upload.*csv")" -O ABC-8x.csv && \
wget -c "https://rossvyaz.ru$(cat reestr-otkrytykh-dannykh | grep -P "CSV-" | sed 's|<br />|\n|gi' | grep "CSV-DEF-9" | grep -oP "/upload.*csv")" -O DEF-9x.csv && \
iconv -f cp1251 -t utf-8 ABC-3x.csv -o ABC-3x.csv.tmp && mv -f ABC-3x.csv.tmp ABC-3x.csv && \
iconv -f cp1251 -t utf-8 ABC-4x.csv -o ABC-4x.csv.tmp && mv -f ABC-4x.csv.tmp ABC-4x.csv && \
iconv -f cp1251 -t utf-8 ABC-8x.csv -o ABC-8x.csv.tmp && mv -f ABC-8x.csv.tmp ABC-8x.csv && \
iconv -f cp1251 -t utf-8 DEF-9x.csv -o DEF-9x.csv.tmp && mv -f DEF-9x.csv.tmp DEF-9x.csv && \
python3 my1.py && \
python3 my2.py && \
ant -f java/build.xml build-geo-data
