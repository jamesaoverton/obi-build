# OBI Build

This is an **experimental** repository for a revised OBI build system. It is based on [commit r4002](https://sourceforge.net/p/obi/code/4002/) to the OBI Subversion repository on SourceForge, with the main OWL file renamed to `edit.owl`, `external-byhand.owl` moved to `imports`, and some updates to import file names and IRIs.


## Use

Clone this repository and `cd` into it:

    git clone https://github.com/jamesaoverton/obi-build.git
    cd obi-build

Then open `edit.owl` in [Protégé](http://protege.stanford.edu). The directory structure and `catalog-v001.xml` file are important, so make sure that Protégé opens the `edit.owl` file in its proper context.
