## How to develop and use PSAGE ##

> (1) Install a recent version of Sage (http://sagemath.org)

> (2) In a new directory, do
```
      hg clone http://purplesage.googlecode.com/hg/ psage 
```

> (3) Build and install:
```
      cd psage; sage -python setup.py develop
```

> Psage uses [setuptools](http://peak.telecommunity.com/DevCenter/setuptools).  Soon we will likely switch to [distribute](http://packages.python.org/distribute/), which is a drop in replacement for setuptools.

> (4) Start sage and import:
```
     sage: import psage
     sage: psage.[tab key]
```

> (5) Some modules need to be explicitly imported still:
```
     sage: from psage.modform.maass import *
```

> (6) If you make changes to Python code in psage, just reload it or restart sage; the changes are automatically noticed.  If you make changes to Cython code in psage, type the following to rebuild the Cython extension code in place:
```
     sage setup.py build_ext --inplace $*
```

> (7) How to run the psage test suite.  First, make sure you install [nose](http://somethingaboutorange.com/mrl/projects/nose/):
```
    sage -sh
    easy_install nose
```
> Then run the test suite from the root of the psage install (say):
```
     sage -sh
     nosetests -v
```
> You can also run nosetests in any subdirectory to test only that directory.   Type `nosetests --help` for command line options, e.g., you can run tests in parallel:
```
    nosetests -v --processes=4
```

> (8) Doctests.  A lot of the code also has doctests, which are **not** run by nosetests above.  To test those, make sure to use the --force\_lib option (in recent versions of Sage), for example:
```
    sage -t --force_lib psage/modform/hilbert/sqrt5/tables.py
```