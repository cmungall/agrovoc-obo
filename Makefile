all: all_subsets
#all: agrovoc_2016-01-21_lod.rdf

ONTS=eo envo go ncbitaxon pdo po to uberon
XOBOS = $(patsubst %, xrefs-%.obo,$(ONTS))
XALIGN = $(patsubst %, align-%.tsv,$(ONTS))
RONTS=$(patsubst %,-r %,$(ONTS))

#%.rdf: %.nt
#	rdfcat -out RDF/XML $< > $@
#	riot $< > $@

## Convert to OBO using Swi-pl
agrovoc.obo: agrovoc_2016-01-21_lod.nt
	swipl -g "use_module(skos2obo),skos2obo('$<','$@')"
.PRECIOUS: agrovoc.obo

## Root terms only
roots.obo: agrovoc.obo
	blip ontol-query -i $< -query "class(ID),\+subclass(ID,_)" -to obo > $@

# Asii hierarchies
hier-%.txt: agrovoc.obo
	blip ontol-subset -i $< -query "class(ID),\+subclass(ID,_)" -down $* -rel subclass > $@
subhier-%.txt: agrovoc.obo
	blip ontol-subset -i $< -query "class(ID,'$*')" -down 6 -rel subclass > $@

# Alignment to different OBOs
align-%.tsv:
	blip-findall -i ignore.pro -consult align_util.pro -u metadata_nlp -r $* -i agrovoc.obo -goal index_entity_pair_label_match "m(X,Y,C)" -use_tabs -label -no_pred > $@.tmp && sort -u $@.tmp > $@

agrovoc-x.obo:
	cut -f1-4 $(XALIGN) | tbl2obolinks.pl --rel corresponds_to -x FAKE:1 --swap > $@

xrefs-%.obo: align-%.tsv
	cut -f1-4 $< | sort -u | tbl2obolinks.pl --rel xref - > $@

allx.obo: $(XOBOS)
	obo-cat.pl $^ > $@
#	owltools $^ --merge-support-ontologies -o -f obo $@

agrovoc-obol.obo: agrovoc.obo
	obol -debug qobolxx qobol -i $< $(RONTS) -i agrovoc-x.obo -export obo -idspace http undefined_only true  > $@.tmp && sort -u $@.tmp > $@


SUBSETS := entities stages measure processes events systems organisms time resources technology products groups
all_subsets: $(patsubst %, subset-%.obo, $(SUBSETS))
subset-%.obo: agrovoc.obo
	blip ontol-query -i $< -query "class(X,'$*'),subclassRT(ID,X)" -to obo > $@.tmp && mv $@.tmp $@

mapped.pro:
	cut -f3 align-*tsv | tbl2p -p m > $@

unmapped.tsv: mapped.pro
	blip-findall  -i $< -i agrovoc.obo "class(X),\+m(X),entity_partition(X,Y)" -select X-Y -no_pred -label > $@

roots-mapped.tsv: agrovoc.obo mapped.pro
	blip-findall -i $< -i mapped.pro "class(ID),\+subclass(ID,_),aggregate(count,X,(subclassT(X,ID),m(X)),N),aggregate(count,X,(subclassT(X,ID),\+m(X)),M),P is N/(N+M)" -select "x(ID,P,N,M)" -label -no_pred > $@.tmp && mv $@.tmp $@
