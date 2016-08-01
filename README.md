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

E.g. https://github.com/FoodOntology/foodon/issues/6

### MIREOTing Agrovoc into OBO Library ontologies

If we can get permission to publish the obo/owl via a purl we can
MIREOT in Agrovoc classes to OBO Library ontologies (would also need
CC-BY).

We would want to swap out some agrovoc PURLs with existing OBO purls -
the above mappings can help with this. For example, we would always
use an NCBITaxon purl for a taxon, or a PO purl for a plant part, a
CHEBI purl for a chemical, etc.

However, with MIREOTing we will run into issues of differing semantics:

```
[Term]
id: http://aims.fao.org/aos/agrovoc/c_928
name: biosynthesis
is_a: http://aims.fao.org/aos/agrovoc/c_27462  ! biochemical reactions
***relationship: makeUseOf http://aims.fao.org/aos/agrovoc/c_2855 ! fermentation
```

not compatible with:

```
id: GO:0006113
name: fermentation
namespace: biological_process
def: "The anaerobic enzymatic conversion of organic compounds, especially carbohydrates, coupling the oxidation and reduction of NAD/H and the generation of adenosine triphosphate (ATP)." [GOC:curators, ISBN:0201090910, ISBN:124925502, MetaCyc:Fermentation]
```


