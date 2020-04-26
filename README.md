# CWL workflows for Data2Services

See **[d2s.semanticscience.org](https://d2s.semanticscience.org/)** for detailed documentation on using the [d2s Command Line Interface](https://pypi.org/project/d2s/).

The [Common Workflow Language](https://www.commonwl.org/) is used to describe workflows to transform heterogeneous structured data (CSV, TSV, RDB, XML, JSON) to a target RDF data model. A generic RDF is generated depending on the input data structure (AutoR2RML, xml2rdf), then [SPARQL queries](https://github.com/MaastrichtU-IDS/data2services-transform-biolink/blob/master/mapping/pharmgkb/insert-pharmgkb.rq), defined by the user, are executed to transform the generic RDF to the target data model.

---

## Requirements

- Install the [d2s client](https://pypi.org/project/d2s/)
- Install [cwlref-runner](https://github.com/common-workflow-language/cwltool#install) to get cwl-runner to run workflows of Docker modules.
- [Docker](https://docs.docker.com/install/) must be installed

```bash
sudo apt install d2s cwlref-runner
```

See [d2s.semanticscience.org](https://d2s.semanticscience.org/docs/d2s-workspace) for complete documentation about the `d2s` CLI.

---

## Clone

```bash
git clone --recursive https://github.com/MaastrichtU-IDS/d2s-core.git
```

