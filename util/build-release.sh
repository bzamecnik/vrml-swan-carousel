#!/bin/sh

ULOHA=2
RELEASE_DIR="tym1-uloha$ULOHA"
WWW_PROJECT_DIR="$HOME/WWW/vr"

# export ze SVN je bez adresaru .svn/
svn export svn://artax.karlin.mff.cuni.cz/home/zameb6am/vr/trunk release
cd release
mkdir $RELEASE_DIR
mv src/* $RELEASE_DIR
mv web/$ULOHA/* $RELEASE_DIR
cd $RELEASE_DIR

# zagzipovat vsechny WRL soubory rekurzivne
find . -iname '*.wrl' -print|xargs gzip
## slo by to pres find a xargs...
## takovy workaround za nefunkcni find na cygwinu:
#gzip */*/*.wrl
#gzip */*.wrl
#gzip *.wrl

# odstraneni .gz
find . -iname '*.wrl.gz' -exec rename .wrl.gz .wrl '{}' \;
# nebo zase workaround za nefunkcni find
# tentokrat v total commanderu:
# CTRL+B
# CTRL+M, vyhledeat regex \.gz$ a smazat

# pak to cele jeste do .zip
# mame tu dva vnorene $RELEASE_DIR, zustane jen ten vnejsi, v ZIPce i ten vnitrni
cd ..
zip -r vse.zip $RELEASE_DIR
cd $RELEASE_DIR

# a komplet vcetne teto ZIPky hodime na web
#rm -r $WWW_PROJECT_DIR/$ULOHA/*
rm -r $WWW_PROJECT_DIR/$ULOHA
mkdir -p $WWW_PROJECT_DIR/$ULOHA
mv * $WWW_PROJECT_DIR/$ULOHA/
cd ..
mv vse.zip $WWW_PROJECT_DIR/$ULOHA/

cd ..
rm -r release

