all: all_subsets
#all: agrovoc_2016-01-21_lod.rdf

#%.rdf: %.nt
#	rdfcat -out RDF/XML $< > $@
#	riot $< > $@

agrovoc.obo: agrovoc_2016-01-21_lod.nt
	swipl -g "use_module(skos2obo),skos2obo('$<','$@')"
.PRECIOUS: agrovoc.obo

roots.obo: agrovoc.obo
	blip ontol-query -i $< -query "class(ID),\+subclass(ID,_)" -to obo > $@

hier-%.txt: agrovoc.obo
	blip ontol-subset -i $< -query "class(ID),\+subclass(ID,_)" -down $* -rel subclass > $@

align-%.tsv:
	blip-findall -i ignore.pro -consult align_util.pro -u metadata_nlp -r $* -i agrovoc.obo -goal index_entity_pair_label_match "m(X,Y,C)" -use_tabs -label -no_pred > $@.tmp && sort -u $@.tmp > $@

SUBSETS := entities stages measure processes events systems organisms time resources technology products groups
all_subsets: $(patsubst %, subset-%.obo, $(SUBSETS))
subset-%.obo: agrovoc.obo
	blip ontol-query -i $< -query "class(X,'$*'),subclassRT(ID,X)" -to obo > $@.tmp && mv $@.tmp $@
