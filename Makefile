# OBI Makefile
# James A. Overton <james@overton.ca>
#
# This is an experimental Makefile
# for building OBI from various sources,
# including OntoFox and ROBOT templates.
# See the README for software requirements.
#
# WARN: This file contains significant whitespace, i.e. tabs!
# Ensure that your text editor shows you those characters.


### Definitions

SHELL := /bin/bash
OBO := http://purl.obolibrary.org/obo/
DEV := $(OBO)obi/dev/
.DEFAULT_GOAL := all


### Imports
#
# The `imports/` directory contains OWL files generated
# from various sources and imported into OBI.
IMPORTS := $(wildcard imports/*.owl)

# Build a catalog file with mappings for all the IMPORTS.
catalog-v001.xml: edit.owl $(IMPORTS)
	echo '<?xml version="1.0" encoding="UTF-8" standalone="no"?>' > $@
	echo '<catalog prefer="public" xmlns="urn:oasis:names:tc:entity:xmlns:xml:catalog">' >> $@
	$(foreach i,$^,echo '  <uri name="$(DEV)$i" uri="$i"/>' >> $@;)
	echo '</catalog>' >> $@

# Update OntoFox import using cURL to fetch the data.
# See http://ontofox.hegroup.org/tutorial/index.php#service
imports/%.owl: ontofox/%.txt
	curl -s -F file=@$< -o $@ http://ontofox.hegroup.org/service.php

# Update template imports using ROBOT.
# See https://github.com/ontodev/robot/blob/master/docs/template.md
# First we create an empty target file, then build the template.
# WARN: Template build order can sometimes be important,
# but that isn't yet handled automatically.
imports/%.owl: templates/%.tsv
	echo '' > $@
	robot merge \
	--input edit.owl \
	template \
	--template $< \
	annotate \
	--ontology-iri "$(DEV)$@" \
	--output $@

# Update all imports.
# NOTE: GNU Make will compare timestamps to see which updates are required.
imports: $(IMPORTS)


### Build

# TODO: Assign IDs

# Merge all imports into a single OWL file,
# and remove all owl:import statements.
#
# - merge
# - TODO: update terms, use SPARQL
# - TODO: remove owl:import statements more elegantly
merged.owl: edit.owl $(IMPORTS)
	robot merge \
	--input edit.owl \
	annotate \
	--ontology-iri "$(DEV)$@" \
	--output temp.$@
	sed '/<owl:imports/d' temp.$@ > $@
	rm temp.$@

# Reason over the merged OWL file.
reasoned.owl: merged.owl
	robot reason \
	--reasoner HermiT \
	--input $^ \
	annotate \
	--ontology-iri "$(DEV)$@" \
	--output $@

# Build a release version of OBI.
#
# - TODO: add DOAP metadata
obi.owl: reasoned.owl
	robot annotate \
	--input $< \
	--ontology-iri "$(OBO)obi.owl" \
	--version-iri "$(OBO)obo/$(shell date +'%Y-%m-%d')/obi.owl" \
	--output $@

# TODO: Create subsets: core, IEDB, ISA

all: obi.owl

### Other

clean:
	rm -f {merged,reasoned,obi}.owl

