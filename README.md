# DcGeneral documentation build

This is the build system for DcGeneral documentation.

It use [reStructuredText](http://docutils.sourceforge.net/rst.html) as markup language,
[Sphinx](http://sphinx-doc.org/) as documentation generator and the
[sphinx-bootstrap-theme](https://pypi.python.org/pypi/sphinx-bootstrap-theme/) as layout.

For reStructuredText markup reference, have a look at the [reStructuredText Primer](http://sphinx-doc.org/rest.html) chapter.
For sphinx markup reference, have a look at the [Sphinx Markup Constructs](http://sphinx-doc.org/markup/index.html) chapter.

# How to install

## Install dependencies

```bash
$ sudo apt-get install python2.7 python-setuptools python-pip
$ sudo easy_install-2.7 Sphinx
$ sudo pip install sphinx_bootstrap_theme
```

## Install build system

```bash
# clone build system
$ git clone -b build https://github.com/tristanlins/dc-general-docs.git
$ cd dc-general-docs

# install vendor libraries
$ curl -sS https://getcomposer.org/installer | php
$ php composer.phar install

# clone documentation into directory "source"
$ git clone -b master https://github.com/tristanlins/dc-general-docs.git source
```

# How to upgrade

## Upgrade build system

```bash
# update build system
$ cd /path/to/dc-general-docs
$ git pull

# update vendor libraries
$ php composer.phar self-update
$ php composer.phar install

# update documentation
$ cd source
$ git pull
```

# How to build documentation

```bash
$ cd /path/to/dc-general-docs
$ make html
```

After `make html` you will find the documentation in `build/html`.

# Publish documentation

## Checkout gh-pages

```bash
$ cd /path/to/dc-general-docs
# if you previously generated the documentation
$ rm -r build
$ git clone -b gh-pages https://github.com/tristanlins/dc-general-docs.git build/html
```

## Update gh-pages

```bash
$ cd /path/to/dc-general-docs

# clean documentation
$ cd build/html
$ git pull
$ git rm -rf *

# build documentation
$ cd ../../
$ make html

# update documentation
$ cd build/html
$ git add .
$ git commit -m "Generated $(date '+%Y-%m-%d %H:%M')"

# publish documentation
$ git push
```
