#!/bin/bash

cd $(dirname $0)
cd ..

# clean documentation
echo
echo -e ' \e[1;34m*\e[00m \e[1;31mclean gh-pages\e[00m'
echo
cd build/html
git pull
git rm -r *

# build documentation
echo
echo -e ' \e[1;34m*\e[00m \e[1;31mbuild documentation\e[00m'
echo
cd ../../
make html

# update documentation
echo
echo -e ' \e[1;34m*\e[00m \e[1;31mupdate gh-pages\e[00m'
echo
cd build/html
git add .
git commit -m "Generated $(date '+%Y-%m-%d %H:%M')"

# publish documentation
echo
echo -e ' \e[1;34m*\e[00m \e[1;31mpublish gh-pages\e[00m'
echo
git push
