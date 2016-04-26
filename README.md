# Agrovoc alignment to OBO Ontologies

This is an exploratory project to align Agrovoc to OBO Library ontologies, in order to

 * identify gaps in ontologies such as ENVO and TO
 * Provide definitions (with full provenance) for OBO classes
 * Provide language translations for OBO classes
 * To explore the addition of OWL semantics to Agrovoc, beyond what can be done in SKOS
 * To explore the possibility of closer integration and collaboration between Agrovoc and OBO communities

For more on OBO, see http://obofoundry.org

## OWL translation of Agrovoc

The prolog program skos2obo.pl translates the skos of agrovoc to OBO/OWL

Note that for compactness we store the OWL in the compact OBO-Format,
but this should be understood to have OWL semantics.

We also provide subset files for convenience. E.g. for aligning to NCBITaxonomy we would use subset-organisms.obo

## Alignments

 * [align-envo.tsv](align-envo.tsv) -- alignment to http://obofoundry.org/ontology/envo.html
 * [align-ncbitaxon.tsv](align-ncbitaxon.tsv) -- alignment to http://obofoundry.org/ontology/ncbitaxon.html
 * [align-pdo.tsv](align-pdo.tsv) -- alignment to http://obofoundry.org/ontology/pdo.html
 * [align-po.tsv](align-po.tsv) -- alignment to http://obofoundry.org/ontology/po.html
 * [align-to.tsv](align-to.tsv) -- alignment to http://obofoundry.org/ontology/to.html
 * [align-uberon.tsv](align-uberon.tsv) -- alignment to http://obofoundry.org/ontology/uberon.html

## Uses

### host-pathogen relationships

See https://github.com/Planteome/plant-stress-ontology

http://globalbioticinteractions.org/

### Food

https://github.com/FoodOntology/foodon/

### MIREOTing Agrovoc into OBO Library ontologies

If we can get permission to publish the obo/owl via a purl we can MIREOT in Agrovoc classes to OBO Library ontologies
